module SessionsHelper
  def sign_in(user)
    session[:signedin_user_token] = [user.id, user.salt]
    @current_user = user
  end
  
  def sign_out
    session.delete(:signedin_user_token)
    @current_user = nil
    redirect_to root_path
  end
  
  def current_user
    @current_user ||= user_from_session
  end
  
  def is_current_user?(user)
    user == current_user
  end
  
  def is_super_admin?
    current_user.is_super_admin?
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def authenticate
    deny_access unless signed_in?
    signed_in?
  end
  
  def authenticate_as_super_admin
    if(authenticate)
      success = is_super_admin?
      sign_out unless success
      success
    end
    false
  end
  
  def authorized_user?
    id = params[:user_id] || params[:id] 
    @user = User.find_by_id(id)
    redirect_to root_path unless is_current_user? @user
  end
  
  def authorized_owner? (scope)
    return is_current_user?(scope.user) if scope.user
    false
  end
  
  def authorized_member? (scope)
    return true if authorized_owner? (scope)
    if(scope.assigned_users)
      return scope.assigned_users.include?(current_user)
    end
    redirect_to root_path
  end
  
  def deny_access
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end
  
  private
    def user_from_session
      User.authenticate_from_session *session_user_token
    end
    
    def session_user_token
      session[:signedin_user_token] || [nil, nil]
    end
end
