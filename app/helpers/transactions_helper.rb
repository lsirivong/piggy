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
  
  def transaction_form(transaction, options={} )
    defaults = {
      :show_cancel => false,
      :show_labels => true
    }
    options = defaults.merge(options)
    
    render(:partial => 'transactions/inline_form', :object => transaction, :locals => { :show_cancel => options[:show_cancel], :show_labels => options[:show_labels] })
  end
  
  def transaction_form_for_envelope_id(envelope_id)
    transaction = Transaction.new(:envelope_id => envelope_id)
    content_tag(:div, transaction_form(transaction), :class => "transaction_entry clearfix")
  end
  
  def list_errors(transaction)
    out = "$('##{dom_id transaction}_errors').html('');"
    @transaction.errors.full_messages.each do |msg|
      out << "$('##{dom_id transaction}_errors').append('<li>#{escape_javascript(msg)}</li>');"
    end
    
    raw out
  end
end
