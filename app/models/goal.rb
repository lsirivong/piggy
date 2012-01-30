class Goal < ActiveRecord::Base
  has_many :transactions, :dependent => :nullify
  belongs_to :user

  after_create do |goal|
    budget = goal.user.latest_budget
    if budget
      if goal.deadline > budget.start_date && goal.starts_at < budget.end_date
        days_in_goal = goal.deadline - goal.starts_at
        save_per_day = goal.amount / days_in_goal
        days_of_budget_for_goal = 1 + ([goal.deadline - 1, budget.end_date].min - [goal.starts_at, budget.start_date].max)
        save_for_goal = (-1 * days_of_budget_for_goal * save_per_day).round(+2)

        Transaction.create(:goal => goal,
          :vendor => "Save for goal: [#{goal.name}]",
          :date => [goal.deadline - 1, budget.end_date].min,
          :envelope => budget.envelopes.first,
          :amount => save_for_goal,
          :is_generated => true)
      end
    end
  end

  def total
    sum = transactions.sum(:amount)
    sum.magnitude
  end 
  
  def remaining
    amount - total
  end
end
