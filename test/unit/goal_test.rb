require 'test_helper'

class GoalTest < ActiveSupport::TestCase

  setup do
    @goal = Goal.new(goals(:one).attributes)
    assert @goal.valid?
  end

  test "recurring goal without recurrance_type should be invalid" do
    @goal.is_recurring = true
    assert @goal.invalid?
  end

  test "recurring goal with recurrance_type should be valid" do
    @goal.is_recurring = true
    @goal.recurrance_type = "string"
    assert @goal.valid?
  end

  test "non recurring goal should not have a recurrance type" do
    @goal.recurrance_type = "string"
    assert @goal.invalid?
  end

  test "should require name" do
    @goal.name = nil
    assert @goal.invalid?
  end

  test "should require amount" do
    @goal.amount = nil
    assert @goal.invalid?
  end

  test "should return correct display text for recurrance_types" do
    @goal.is_recurring = true
    @goal.recurrance_type = "PER_MONTH"
    @goal.starts_at = Date.new(2012, 1, 1)
    @goal.deadline = Date.new(2012, 2, 1)
    assert_equal "1st of every Month", @goal.recurrance_type_display

    @goal.recurrance_type = "PER_DAY"
    assert_equal "Every 31 days", @goal.recurrance_type_display
  end

  test "days_long should return days between deadline and starts_at" do
    @goal.starts_at = Date.new(2012, 1, 1)
    @goal.deadline = Date.new(2012, 2, 1)
    assert_equal 31, @goal.days_long
  end

  test "recurrance should return nil if not recurring" do
    assert_nil @goal.recurrance
  end

  test "recurrance for PER_MONTH should return goal with same settings for following month" do
    @goal.is_recurring = true
    @goal.recurrance_type = "PER_MONTH"
    @goal.starts_at = Date.new(2012, 1, 1)
    @goal.deadline = Date.new(2012, 2, 1)

    recurrance = @goal.recurrance
    assert_equal Date.new(2012, 2, 1), recurrance.starts_at
    assert_equal Date.new(2012, 3, 1), recurrance.deadline
    assert_equal @goal.amount, recurrance.amount
    assert_equal @goal.name, recurrance.name
    assert_equal @goal.user_id, recurrance.user_id
    assert_equal true, recurrance.is_active
    assert_equal @goal.is_recurring, recurrance.is_recurring
    assert_equal @goal.recurrance_type, recurrance.recurrance_type
  end

  test "recurrance for PER_DAY should return goal with same settings for same duration" do
    @goal.is_recurring = true
    @goal.recurrance_type = "PER_DAY"
    @goal.starts_at = Date.new(2012, 1, 1)
    @goal.deadline = Date.new(2012, 2, 1)

    recurrance = @goal.recurrance
    assert_equal Date.new(2012, 2, 1), recurrance.starts_at
    assert_equal Date.new(2012, 2, 1) + 31, recurrance.deadline
    assert_equal @goal.amount, recurrance.amount
    assert_equal @goal.name, recurrance.name
    assert_equal @goal.user_id, recurrance.user_id
    assert_equal true, recurrance.is_active
    assert_equal @goal.is_recurring, recurrance.is_recurring
    assert_equal @goal.recurrance_type, recurrance.recurrance_type
  end
end
