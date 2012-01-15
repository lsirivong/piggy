class DashboardController < ApplicationController
  def show
    if 0 < Budget.count
      redirect_to Budget.order("created_at DESC").first
    else
      session[:no_budgets_found] = true
      redirect_to new_budget_path
    end
  end

end
