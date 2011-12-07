class Transaction < ActiveRecord::Base
  validates :date,    :presence => true
  validates :vendor,  :presence => true
  validates :amount,  :presence => true,
                      :format   => { 
                        :with => /\A-?[[:digit:]]+\.?[[:digit:]]{,2}\Z/,
                        :message => "Amount may not have more than two decimal places."
                      }
end
