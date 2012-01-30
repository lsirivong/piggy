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
end
