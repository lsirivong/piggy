require 'test_helper'

class EnvelopeTest < ActiveSupport::TestCase
  test "spent should sum up transaction amounts" do
    e = envelopes(:meals)
    lunch = transactions(:lunch)
    dinner = transactions(:dinner)
    
    assert e.spent == lunch.amount + dinner.amount, "spent should be the sum of its transactions"
    
    drinks = Transaction.new
    drinks.vendor = "Bar"
    drinks.date = Date.today
    drinks.amount = -13.22
    drinks.envelope = e
    assert drinks.save!
    
    assert e.spent == lunch.amount + dinner.amount + drinks.amount
  end
end
