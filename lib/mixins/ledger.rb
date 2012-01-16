module Ledger
  # assumes spent and amount methods are defined
  
  def spent
    [sum, 0].min.abs
  end
  
  def remaining
    [net, 0].max
  end
  
  def spent_over?
    net < 0
  end
  
  def amount_over
    [net, 0].min.abs
  end
  
  private
  
  def net
    amount + sum
  end
end
