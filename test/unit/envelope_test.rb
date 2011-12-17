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
  
  test "budget must not be nil" do
    e = envelopes(:one)
    assert e.valid?
    
    e.budget = nil
    assert e.invalid?
  end
  
  test "budget must exist" do
    e = envelopes(:one)
    assert e.valid?
    
    e.budget_id = 0
    assert e.invalid?
    assert e.errors[:budget].any?
  end
end
