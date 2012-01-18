class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login

  protected
  def not_authenticated
    redirect_to new_user_session_path, :alert => "Please login first."
  end
end
