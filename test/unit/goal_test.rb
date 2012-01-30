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
end
