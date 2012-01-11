module ApplicationHelper
  def formatted_date date
    date.strftime("%b %d")
  end
  
  def link_to_edit_transaction(name, transaction)
    fields = transaction_form transaction, :show_actions => true

    li = content_tag(:li, fields, :id => dom_id(transaction))

    link_to_function(name, "add_fields_to_edit_transaction('#{dom_id(transaction)}', '#{escape_javascript(li)}')")
  end
  
  def recalculate_envelope(envelope)
    "$('##{dom_id envelope}_available').html('#{financial_format envelope.amount_available}');"
  end
  
  def link_to_unless_nil(text, object)
    link_to(text, object) unless object.nil?
  end
end
