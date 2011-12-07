class Transaction < ActiveRecord::Base
  validates :date,    :presence => true
  validates :vendor,  :presence => true
  validates :amount,  :presence => true,
                      :format   => { 
                        :with => /\A-?[[:digit:]]+\.?[[:digit:]]{,2}\Z/,
                        :message => "Must be a number with at most two decimal places."
                      }
                      
  belongs_to :envelope
end
