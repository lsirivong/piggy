class Envelope < ActiveRecord::Base
  has_many :transactions, :dependent => :nullify
  
  accepts_nested_attributes_for :transactions, :reject_if => :all_blank, :allow_destroy => true
  def total
    transactions.sum(:amount)
  end 
end
