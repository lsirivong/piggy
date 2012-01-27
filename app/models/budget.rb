class Budget < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :presence => true
  has_many :envelopes, :dependent => :destroy
  has_many :transactions, :through => :envelopes, :order => 'date DESC, created_at DESC'
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validate :end_must_be_after_start

  accepts_nested_attributes_for :envelopes

  after_update do |budget|
    budget.compute_envelope_amounts
  end

  after_create do |budget|
    budget.compute_envelope_amounts

    budget.user.goals.each do |goal|
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

  def end_must_be_after_start
    if (end_date.present? && start_date.present? && (end_date <=> start_date) <= 0)
      errors.add(:end_date, "must be after start date")
    end
  end

  def previous_budget
    user.budgets.first(:conditions => ["end_date < ?", end_date], :order => "end_date desc")
  end

  def next_budget
    user.budgets.first(:conditions => ["end_date > ?", end_date], :order => "end_date asc")
  end

  def expired?
    end_date < Date.today
  end

  def days_long
    (end_date - start_date).to_i + 1
  end

  include Ledger # requires sum and amount methods
  def sum
    transactions.sum(:amount)
  end

  def compute_envelope_amounts
    envelopes.each do |e|
      e.compute_amount
      e.save!
    end
  end
end
