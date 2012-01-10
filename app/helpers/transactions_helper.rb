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
    form_for(transaction, :remote => true) do |f|
      out = render("envelopes/transaction_fields", :f => f)
      out << hidden_field_tag(:time, DateTime.now, :class => "form_id", :id => "transaction_form_time")
      out << f.submit(:onfocus => "submit_focus('new_transaction')", :disable_with => "Saving...")
    end
  end
end
