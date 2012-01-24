require 'test_helper'

class BudgetTest < ActiveSupport::TestCase
  test "start date must not be nil" do
    b = budgets(:one)
    assert b.valid?
    b.start_date = nil
    assert b.invalid?
    assert b.errors[:start_date].any?
  end
  
  test "end date must not be nil" do
    b = budgets(:one)
    assert b.valid?
    b.end_date = nil
    assert b.invalid?
    assert b.errors[:end_date].any?
  end
  
  test "end date may not be before start date" do
    b = budgets(:one)
    assert b.valid?
    b.end_date = b.start_date - 1
    assert b.invalid?
    assert b.errors[:end_date].any?
  end
  
  test "end date may not be same as start date" do
    b = budgets(:one)
    assert b.valid?
    b.end_date = b.start_date
    assert b.invalid?
    assert b.errors[:end_date].any?
  end
  
  test "end date can be greater than start date" do
    b = budgets(:one)
    assert b.valid?
    b.end_date = b.start_date + 1
    assert b.valid?
  end

  test "expired? should be true if end_date is before today" do
    b = budgets(:one)
    assert b.end_date < Date.today
    assert b.expired?, "budget should be expired"
  end

  test "expired? should be false if end_date is after today" do
    b = Budget.create(:start_date => Date.today,
      :end_date => Date.today + 14,
      :amount => 100)

    assert !b.expired?, "budget should not be expired"
  end

  test "days_long returns duration of budget" do
    today = Date.today
    tomorrow = Date.tomorrow
    b = Budget.new(:start_date => today,
      :end_date => tomorrow,
      :amount => 100)

    assert_equal 2, b.days_long
  end
end
