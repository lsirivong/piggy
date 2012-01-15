class Envelope < ActiveRecord::Base
  validates :budget_percent, :presence => true
  has_many :transactions, :dependent => :destroy
  belongs_to :budget
  
  accepts_nested_attributes_for :transactions, :reject_if => :all_blank, :allow_destroy => true
  def spent
    transactions.sum(:amount)
  end
  
  def budget_amount
    (budget_percent / 100.0) * budget.amount
  end
  
  def remaining
    budget_amount + spent
  end
end
