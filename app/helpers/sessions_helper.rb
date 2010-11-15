module SessionsHelper
  def sign_in(user)
    session[:signedin_user_token] = [user.id, user.salt]
    current_user = user
  end
  
  def sign_out
    session.delete(:signedin_user_token)
    current_user = nil
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_session
  end
  
  def is_current_user?(user)
    user == current_user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  private
    def user_from_session
      User.authenticate_from_session *session_user_token
    end
    
    def session_user_token
      session[:signedin_user_token] || [nil, nil]
    end
end
