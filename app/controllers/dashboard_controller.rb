class DashboardController < ApplicationController

  def show
    if current_user.budgets.any?
      @budget = current_user.latest_budget
      @goals = current_user.active_goals
    else
      redirect_to new_budget_path, notice: notice
    end
  end
end
