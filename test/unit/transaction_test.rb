require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test "transaction vendor must not be empty" do
    tx = Transaction.new
    assert tx.invalid?
    assert tx.errors[:vendor].any?
  end
  
  test "transaction date must not be empty" do
    tx = Transaction.new
    assert tx.invalid?
    assert tx.errors[:date].any?
  end
  
  test "transaction amount must not be empty" do
    tx = Transaction.new
    assert tx.invalid?
    assert tx.errors[:amount].any?
  end
end
