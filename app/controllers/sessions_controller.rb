class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end
  
  def create
    @user = User.authenticate(params[:session][:email], params[:session][:password])
    if( !@user.nil? )
      sign_in(@user)
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
