module TransactionsHelper
  def amount_tag(amount, invert)
    amount = -1 * amount if invert
    if amount < 0
      dir = 'neg'
    elsif amount > 0
      dir = 'pos'
    else
      dir = 'zero'
    end
    content_tag(:i, financial_format(amount), :class => "amount #{dir}")
  end
  
  def transaction_list(transactions)
    render :partial => 'transactions/table', :locals => { :transactions => transactions }
  end
  
  def transaction_form(envelope_id)
    transaction = Transaction.new
    transaction.envelope_id = envelope_id # may want to validate envelope_id here.
    render :partial => 'transactions/inline_form', :object => transaction
  end
end
