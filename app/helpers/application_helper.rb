module ApplicationHelper
  def formatted_date date
    date.strftime("%b %d")
  end
  
  def formatted_money value
    format "$%#.2f", value
  end
  
  def link_to_edit_transaction(name, transaction)
    fields = form_for(transaction, :remote => true) do |f|
      output = render("envelopes/transaction_fields", :f => f)
      output << f.submit
      output << link_to('Cancel', transaction, :remote => true)
    end

    li = content_tag(:li, fields, :id => dom_id(transaction))

    link_to_function(name, "add_fields_to_edit_transaction('#{dom_id(transaction)}', '#{escape_javascript(li)}')")
  end
  
  def recalculate_envelope(envelope)
    "$('##{dom_id envelope} .available').html('#{formatted_money envelope.amount_available}');"
  end
end
