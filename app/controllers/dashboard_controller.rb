class DashboardController < ApplicationController
  def show
    @budgets = Budget.all
    @goals = Goal.all
  end

end
