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
  
  test "transaction amount must be a number with no more than two decimals" do
    tx_one = transactions(:one)
    assert tx_one.valid?, "Default should be valid"
    
    tx_one.amount = 0.245
    assert tx_one.invalid?, "3 decimal places should be invalid"
    
    tx_one.amount = 0
    assert tx_one.valid?, "0 should be valid"
    
    tx_one.amount = -23.99
    assert tx_one.valid?, "Negative value with 2 decimal places should be valid"
  end
end
