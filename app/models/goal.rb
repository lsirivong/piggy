class Goal < ActiveRecord::Base
  has_many :transactions, :dependent => :nullify
  
  def total
    sum = transactions.sum(:amount)
    sum.magnitude
  end 
end
