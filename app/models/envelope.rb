class Envelope < ActiveRecord::Base
  validates :budget_id, :presence => true
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
end
