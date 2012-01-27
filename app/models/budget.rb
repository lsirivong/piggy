class Budget < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :presence => true
  has_many :envelopes, :dependent => :destroy
  has_many :transactions, :through => :envelopes, :order => 'date DESC, created_at DESC'
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validate :end_must_be_after_start
  
  accepts_nested_attributes_for :envelopes

  after_create do |budget|
    budget.user.goals.each do |goal|
      if goal.deadline > budget.start_date
        days_to_deadline = goal.deadline - budget.start_date # TODO: check off by one...
        save_per_day = goal.remaining / days_to_deadline
        save_for_goal = (-1 * budget.days_long * save_per_day).round(+2)
  
        Transaction.create(:goal => goal,
          :vendor => "Save for goal: [#{goal.name}]",
          :date => budget.end_date,
          :envelope_id => 0, #budget.envelopes.first,
          :amount => save_for_goal)
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
end
