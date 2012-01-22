class DashboardController < ApplicationController
  def show
    if current_user.budgets.any?
      @budget = current_user.budgets.order("created_at DESC").first
      @goals = Goal.all
    else
      redirect_to new_budget_path
    end
  end

end
