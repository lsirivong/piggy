class Goal < ActiveRecord::Base
  has_many :transactions, :dependent => :nullify
end
