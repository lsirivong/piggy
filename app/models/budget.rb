class Budget < ActiveRecord::Base
  has_many :envelopes
end
