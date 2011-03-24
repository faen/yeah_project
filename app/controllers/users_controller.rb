class UsersController < ApplicationController
  
  before_filter :authenticate_as_super_admin, :only => [:index]
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :authorized_user?, :only => [:show, :edit]
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def new_assignment
    @assignment_user = User.new
    @user_assignables = @assignment_user.assignables
    render 'new_assignment'
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      @user.realms.create(:name => "default realm: #{@user.name}")
      UserMailer.signup_confirmation(@user).deliver
      @title = "Sign up success"
      render 'signup_confirmation'
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def create_assignment
    @assignment_user = User.new(params[:user])
    if(@assignment_user.save)
      UserMailer.invitation_confirmation(@assignment_user).deliver
      render 'assignment_confirmation' 
    else
      @user_assignables = @assignment_user.assignables
      render 'new_assignment'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @realms = @user.realms
    @user_projects = ProjectsMember.find_all_by_user_id(@user)
    @projects = @user_projects.map {|u_p| u_p.project }
    @title = "show #{@user.email}"
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def edit_assignments
    @assignment_user = User.find(params[:id])
    @user_assignables = @assignment_user.assignables
  end
  
  def update
    @user = User.find(params[:id])
    if( ! params[:user][:email].nil? && ! params[:user][:email].blank?)
      @user.update_attributes params[:user]
      if @user.save
        @ack = @user.email_acknowledgement
        @ack.reset!
        @user.save!
        sign_out
        UserMailer.signup_confirmation(@user).deliver unless Rails.env == 'test'
      else
        render 'edit'
      end
    elsif( ! params[:user][:password].nil? && ! params[:user][:password].blank?)
      @user.update_attributes params[:user]
      if @user.save
        render 'edit'
      else
        render 'edit'
      end
    else
      @user.update_attributes params[:user]
      @user.save
      @assignment_user = User.find(params[:id])
      @user_assignables = @assignment_user.assignables
      render 'edit'
    end
  end
  
  def confirm_user_email_address
    if( !params[:token].nil? )
      @ack = EmailAcknowledgement.find_by_token(params[:token])
      @user = @ack.email_acknowledgeable unless @ack.nil?
    end
    if( !@user.nil? )
      if( @ack.expired? )
        flash[:notice] = "Confirmation link expired"
      elsif( @ack.acknowledged? )
        flash[:notice] = "Confirmation link already used"
        locals = {:initial => false}
      else
        @ack.confirm
        @ack.save
        locals = {:initial => true}
      end
      render 'signup_confirmation', :locals => locals
    else
      redirect_to root_path
    end
  end
  
  def create_credentials
    puts "create_credentials, token: #{params[:token]}"
    if( !params[:token].nil? )
      @ack = EmailAcknowledgement.find_by_token(params[:token])
      puts " - @ack: #{@ack}"
      @user = @ack.email_acknowledgeable unless @ack.nil?
      puts " - @user: #{@user}"
    end
    if(@user)
      @user.update_attributes(params[:user])
      sign_in(@user)
      redirect_to user_path(@user)
    else
      redirect_to root_path
    end
  end
end
