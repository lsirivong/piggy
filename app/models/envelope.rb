class Envelope < ActiveRecord::Base
  validates :budget_percent, :presence => true
  has_many :transactions, :dependent => :destroy
  belongs_to :budget
  
  accepts_nested_attributes_for :transactions, :reject_if => :all_blank, :allow_destroy => true
  
  include Ledger #requires spent and amount methods
  def spent
    transactions.sum(:amount).abs
  end
  def amount
    (budget_percent / 100.0) * budget.amount
  end
end
