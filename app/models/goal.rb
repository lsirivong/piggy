class Goal < ActiveRecord::Base
  include ActiveSupport::Inflector

  has_many :transactions, :dependent => :nullify
  belongs_to :user
  validate :recurring_goals_must_have_type
  validates_presence_of :name
  validates_presence_of :amount

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

  def recurrance_type_display
    display = ""
    case self.recurrance_type
    when nil
      display = ""
    when "PER_MONTH"
      display = "#{ordinalize(self.deadline.day)} of every Month"
    when "PER_DAY"
      days = (self.deadline - self.starts_at).to_i
      display = "Every #{days} #{days > 1 ? pluralize("day") : "day"}"
    end

    display
  end

  def total
    sum = transactions.sum(:amount)
    sum.magnitude
  end 
  
  def remaining
    amount - total
  end

  private

  def recurring_goals_must_have_type
    if self.is_recurring && self.recurrance_type.nil?
      self.errors.add(:recurrance_type, "is required for recurring goals")
    elsif !self.is_recurring && self.recurrance_type.present?
      self.errors.add(:recurrance_type, "should be nil if not recurring")
    end
  end
end
