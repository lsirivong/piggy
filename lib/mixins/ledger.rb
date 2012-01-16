module Ledger
  # assumes spent and amount methods are defined
  
  def remaining
    [net, 0].max
  end
  
  def spent_over?
    spent > amount
  end
  
  def amount_over
    [net, 0].min.abs
  end
  
  private
  
  def net
    amount - spent
  end
end