class Transaction < ActiveRecord::Base
  validates :date,    :presence => true
  validates :vendor,  :presence => true
  validates :amount,  :presence => true
end
