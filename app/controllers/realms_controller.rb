class RealmsController < ApplicationController
  
  before_filter :authorized_user?, :only => [:index, :new, :create, :destroy]
  before_filter :authorized_realm_member?, :only => [:show, :edit, :update]
  
  def index
    # @user = current_user --> set by before_filter
    @realms = @user.realms
  end
  
  def new
    # @user = current_user --> set by before_filter
    @realm = @user.realms.build
  end
  
  def create
    # @user = current_user --> set by before_filter
    @realm = @user.realms.build params[:realm]
    if(@user.save)
      redirect_to user_realm_path(@user, @realm)
    else
      render 'new'
    end
  end
  
  def show
    # @realm = Realm.find_by_id(params[:id]) --> set by before_filter
    @products = @realm.products
  end
  
  def edit
    # @realm = Realm.find_by_id(params[:id]) --> set by before_filter
  end
  
  def update
    @user = current_user
    # @realm = Realm.find_by_id(params[:id]) --> set by before_filter
    if(@realm.update_attributes params[:realm])
      redirect_to user_realms_path(@user)
    else
      @realms = @user.realms
      render 'edit'
    end
  end
  
  def destroy
    # @user = current_user --> set by before_filter
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