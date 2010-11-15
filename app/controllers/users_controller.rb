class UsersController < ApplicationController
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def show
    @user = User.find(params[:id])
    @title = "show #{@user.email}"
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

end
