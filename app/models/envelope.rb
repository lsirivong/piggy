class Envelope < ActiveRecord::Base
  validates :budget_percent, :presence => true
  validates :budget_id, :presence => true
  has_many :transactions, :dependent => :destroy
  belongs_to :budget
  
  accepts_nested_attributes_for :transactions, :reject_if => :all_blank, :allow_destroy => true
  
  include Ledger # requires sum and amount methods
  def sum
    transactions.sum(:amount)
  end
  def amount
    (budget_percent / 100.0) * budget.amount
  end
end
