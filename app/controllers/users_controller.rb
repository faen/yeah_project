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

end
