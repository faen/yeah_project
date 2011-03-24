class RealmsController < ApplicationController
  
  before_filter :authorized_user?, :only => [:index, :new, :create, :destroy]
  before_filter :authorized_realm_member?, :only => [:show, :edit, :update]
  
  def index
    @realms = @user.realms
    @assigned_realms = @user.assigned_realms
  end
  
  def new
    @realm = @user.realms.build
  end
  
  def create
    @realm = @user.realms.build params[:realm]
    if(@user.save)
      redirect_to user_realm_path(@user, @realm)
    else
      render 'new'
    end
  end
  
  def show
    @products = @realm.products
    @assigned_users = @realm.crowd
  end
  
  def edit

  end
  
  def update
    @user = current_user
    if(@realm.update_attributes params[:realm])
      redirect_to user_realms_path(@user)
    else
      @realms = @user.realms
      render 'edit'
    end
  end
  
  def destroy
    @realm = Realm.find_by_id(params[:id])
    @realm.destroy
    redirect_to user_realms_path(@user)
  end
  
private 
  def authorized_realm_member?
    @realm = Realm.find_by_id(params[:id])
    authorized_member?(@realm)
  end
end