module ApplicationHelper
  def formatted_date date
    date.strftime("%b %d")
  end
  
  def formatted_money value
    format "$%#.2f", value
  end
  
  def link_to_edit_transaction(name, transaction)
    fields = form_for(transaction) do |f|
      output = render("envelopes/transaction_fields", :f => f)
      output << f.submit
      output
    end

    link_to_function(name, "add_fields_to_edit_transaction('#{dom_id(transaction)}', '<li>#{escape_javascript(fields)}</li>')")
  end
end
