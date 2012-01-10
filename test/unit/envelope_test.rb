require 'test_helper'

class EnvelopeTest < ActiveSupport::TestCase
  test "total should sum up transaction amounts" do
    e = envelopes(:meals)
    lunch = transactions(:lunch)
    dinner = transactions(:dinner)
    
    assert e.total == lunch.amount + dinner.amount, "total should be the sum of its transactions"
    
    drinks = Transaction.new
    drinks.vendor = "Bar"
    drinks.date = Date.today
    drinks.amount = -13.22
    drinks.envelope = e
    assert drinks.save!
    
    assert e.total == lunch.amount + dinner.amount + drinks.amount
  end
end
