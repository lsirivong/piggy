class Envelope < ActiveRecord::Base
  has_many :transactions
end
