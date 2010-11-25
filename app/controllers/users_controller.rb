class UsersController < ApplicationController
  
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :authorized_user?, :only => [:edit, :update]
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.signup_confirmation(@user).deliver
      @title = "Sign up success"
      render 'signup_confirmation'
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @user_projects = ProjectsMember.find_all_by_user_id(@user)
    @projects = @user_projects.map {|u_p| u_p.project }
    @title = "show #{@user.email}"
  end
  
  def edit
    # @user = User.find_by_id(params[:id])
  end
  
  def update
    # @user = User.find_by_id(params[:id])
    if( ! params[:user][:email].nil? && ! params[:user][:email].blank?)
      @user.update_attributes params[:user]
      if @user.save
        @ack = @user.email_acknowledgement
        @ack.reset!
        sign_out
        UserMailer.signup_confirmation(@user).deliver
      end
    else
      @user.update_attributes params[:user]
      @user.save      
    end
    render 'edit'
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
      else
        @ack.confirm
        @ack.save
      end
      render 'signup_confirmation'
    else
      redirect_to root_path
    end
  end
  
  private
    def authorized_user?
      @user = User.find_by_id(params[:id])
      redirect_to root_path unless is_current_user? @user
    end

end
