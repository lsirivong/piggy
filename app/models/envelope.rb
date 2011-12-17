class Envelope < ActiveRecord::Base
  validates :budget_id, :presence => true
  validates :budget_percent, :presence => true
  has_many :transactions, :dependent => :nullify
  belongs_to :budget
  validate :budget_must_exist
  
  accepts_nested_attributes_for :transactions, :reject_if => :all_blank, :allow_destroy => true
  def total
    transactions.sum(:amount)
  end 
  
  def budget_must_exist
    if budget.nil?
      errors.add(:budget, "assigned budget does not exist")
    end
  end
  
  def budget_amount
    (budget_percent / 100.0) * budget.amount
  end
  
  def amount_available
    budget_amount + total
  end
end
