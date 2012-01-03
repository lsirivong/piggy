class DashboardController < ApplicationController
  def show
    @budgets = Budget.order("created_at DESC").limit(5)
    @goals = Goal.all
  end

end
