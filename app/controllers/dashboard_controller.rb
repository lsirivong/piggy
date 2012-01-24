class DashboardController < ApplicationController

  def show
    if current_user.budgets.any?
      @budget = current_user.latest_budget
      @goals = Goal.all
    else
      redirect_to new_budget_path
    end
  end

  def generate_budgets
    latest_budget = current_user.latest_budget

    if latest_budget.present?
      today = Date.today
      budgets_generated = 0

      while latest_budget.expired? || budgets_generated > 10 # Stop before it gets too crazy

        new_start = latest_budget.end_date + 1
        new_end = new_start + latest_budget.days_long

        new_budget = Budget.new(:amount => latest_budget.amount,
          :start_date => new_start,
          :end_date => new_end,
          :user_id => current_user.id)

        latest_budget.envelopes.each do |e|
          new_env = Envelope.new(:name => e.name, :budget_id => new_budget.id, :budget_percent => e.budget_percent)
          new_budget.envelopes << new_env
        end

        new_budget.save!
        budgets_generated += 1

        latest_budget = new_budget
      end

      flash[:notice] = "Created #{budgets_generated} budget(s) based on the last"
    end

    redirect_to current_user.latest_budget
  end

end
