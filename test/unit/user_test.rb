require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "latest_budget should get budget with most recent end date" do
    dave = users(:dave)
    assert dave.budgets.any?

    latest_budget = dave.latest_budget
    assert latest_budget.present?

    latest_date = nil
    dave.budgets.each do |b|
      if latest_date.nil?
        latest_date = b.end_date
      else
        latest_date = b.end_date if b.end_date > latest_date
      end
    end

    assert latest_date == latest_budget.end_date

    b = Budget.create(:start_date => latest_date + 1, :end_date => latest_date + 2, :amount => 100, :user_id => dave.id)

    assert b.end_date == dave.latest_budget.end_date
  end

  test "latest_budget should return nil if no budgets" do
    new_user = users(:new_user)
    assert new_user.budgets.none?
    assert new_user.latest_budget.nil?
  end
end
