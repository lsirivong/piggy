class Envelope < ActiveRecord::Base
  has_many :transactions, :dependent => :nullify
  
  def total
    transactions.sum(:amount)
  end 
end
