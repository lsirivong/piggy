class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login

  protected
  def not_authenticated
    redirect_to new_user_session_path, :alert => "Please login first."
  end

  def require_ownership(user_id)
    unless user_id == current_user.id
      redirect_to current_user, notice: 'That does not belong to you'
    end
  end
end
