require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  setup do
    @tx_one = transactions(:one)
    assert @tx_one.valid?, "Setup: transactions(:one) should be valid"
  end
  
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
    @tx_one.amount = 0.245
    assert @tx_one.invalid?, "3 decimal places should be invalid"
    
    @tx_one.amount = 0
    assert @tx_one.valid?, "0 should be valid"
    
    @tx_one.amount = -23.99
    assert @tx_one.valid?, "Negative value with 2 decimal places should be valid"
  end
  
  test "transaction envelope must exist if assigned" do
    #set envelope id to something outrageous (ID is never 0)
    @tx_one.envelope_id = 0
    assert @tx_one.invalid?, "No envelope should exist with id == 0"
    assert @tx_one.errors[:envelope].any?
  end
  
  test "transaction with nil envelop should be valid" do
    @tx_one.envelope_id = nil
    assert @tx_one.valid?, "Nil envelope id should be valid"
  end
  
  test "transaction with existing envelope should be valid" do
    e = envelopes(:one)
    @tx_one.envelope_id = e.id
    assert @tx_one.valid?, "Existing envelope should be valid"
  end
  
  test "transaction goal must exist if assigned" do
    #set goal id to something outrageous (ID is never 0)
    @tx_one.goal_id = 0
    assert @tx_one.invalid?, "No goal should exist with id == 0"
    assert @tx_one.errors[:goal].any?
  end
  
  test "transaction with nil goal should be valid" do
    @tx_one.goal_id = nil
    assert @tx_one.valid?, "Nil goal id should be valid"
  end
  
  test "transaction with existing envelop should be valid" do
    e = goals(:one)
    @tx_one.goal_id = e.id
    assert @tx_one.valid?, "Existing goal should be valid"
  end
end
