class DashboardController < ApplicationController
  before_filter :handle_expired_budgets

  def show
    if current_user.budgets.any?
      @budget = current_user.latest_budget
      @goals = Goal.all
    else
      redirect_to new_budget_path
    end
  end

  def handle_expired_budgets
    if !current_user.latest_budget || current_user.latest_budget.expired?
      flash[:notice] = "Latest budget does not exist or is expired"
    end
  end
end
