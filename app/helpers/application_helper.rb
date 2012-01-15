module ApplicationHelper
  def formatted_date date
    date.strftime("%b %d")
  end
  
  def link_to_edit_transaction(name, transaction)
    fields = transaction_form transaction, :show_cancel => true, :show_labels => false

    li = content_tag(:li, fields, :id => dom_id(transaction))

    link_to_function(name, "add_fields_to_edit_transaction('#{dom_id(transaction)}', '#{escape_javascript(li)}')")
  end
  
  def recalculate_envelope(envelope)
    "$('##{dom_id envelope}_available').html('#{financial_format envelope.amount_available}');"
  end
  
  def recalculate_stats(transaction)
    envelope = transaction.envelope
    animation_after = "
    .animate(
      { opacity: 1 },
       350, function() {
         // Animation complete.
      }
    )"
    animate = "$('%s').animate(
      { opacity: 0 },
       350, function() {
         $(this).html('%s').animate(
           { opacity: 1 },
           350, function() {
             // Animation complete.
           }
        );
      }
    );"
    out = animate % ["#budget_remaining i", "#{financial_format envelope.budget.remaining.abs}"]
    out << animate % ["#budget_spent i", "#{financial_format envelope.budget.spent.abs}"]
    out << animate % ["##{dom_id envelope} .remaining i", "#{financial_format envelope.remaining.abs}"]
    out << animate % ["##{dom_id envelope} .spent i", "#{financial_format envelope.spent.abs}"]
    goal = transaction.goal
    unless goal.nil?
      out << animate % ["##{dom_id goal} .saved i", "#{financial_format goal.total}"]
      out << animate % ["##{dom_id goal} .remaining i", "#{financial_format goal.remaining}"]
    end
  end
  
  def link_to_unless_nil(text, object)
    link_to(text, object) unless object.nil?
  end
end
