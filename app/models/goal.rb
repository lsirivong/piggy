class Goal < ActiveRecord::Base
  has_many :transactions, :dependent => :nullify
  belongs_to :user
  
  def total
    sum = transactions.sum(:amount)
    sum.magnitude
  end 
  
  def remaining
    amount - total
  end
end
