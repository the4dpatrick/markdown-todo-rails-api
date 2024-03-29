class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def current_user?(user)
    user == current_user
  end

  def correct_user
    @user ||= User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def authorize
    case request.format
    when Mime::JSON, Mime::XML, Mime::ATOM
      authenticate_or_request_with_http_token do |token, options|
        user = User.find(params[:user_id])
        if user
          user.api_keys.exists?(access_token: token)
        end
      end
    else
      redirect_to signin_url, alert: 'Not authorized' if current_user.nil?
    end
  end
end
