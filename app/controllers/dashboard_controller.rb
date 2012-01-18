class DashboardController < ApplicationController
  def show
    if current_user.budgets.any?
      redirect_to current_user.budgets.order("created_at DESC").first
    else
      session[:no_budgets_found] = true
      redirect_to new_budget_path
    end
  end

end
