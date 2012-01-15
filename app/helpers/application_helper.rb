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
    
    budget = envelope.budget
    out = animate % ["#budget_remaining .value", "#{financial_format budget.remaining}"]
    out << animate % ["#budget_spent .value", "#{financial_format budget.spent.abs}"]
  
    if budget.spent_too_much
      out << "if ($('#budget_spent .amount_over_wrap').is('.hidden')) { $('#budget_spent .amount_over_wrap').removeClass('hidden')}"
    else
      out << "if (!$('#budget_spent .amount_over_wrap').is('.hidden')) { $('#budget_spent .amount_over_wrap').addClass('hidden')}"
    end
    
    out << animate % ["#budget_spent .amount_over", "#{financial_format budget.amount_over}"]
    
    out << animate % ["##{dom_id envelope} .remaining .value", "#{financial_format envelope.remaining.abs}"]
    out << animate % ["##{dom_id envelope} .spent .value", "#{financial_format envelope.spent.abs}"]
  
  
    out << animate % ["##{dom_id envelope} .spent .amount_over", "#{financial_format envelope.amount_over}"]
    
    if envelope.spent_too_much
      out << "if ($('##{dom_id envelope} .spent .amount_over_wrap').is('.hidden')) { $('##{dom_id envelope} .spent .amount_over_wrap').removeClass('hidden')}"
    else
      out << "if (!$('##{dom_id envelope} .spent .amount_over_wrap').is('.hidden')) { $('##{dom_id envelope} .spent .amount_over_wrap').addClass('hidden')}"
    end
    
    goal = transaction.goal
    unless goal.nil?
      out << animate % ["##{dom_id goal} .saved .value", "#{financial_format goal.total}"]
      out << animate % ["##{dom_id goal} .remaining .value", "#{financial_format goal.remaining}"]
    end
    
    return out
  end
  
  def link_to_unless_nil(text, object)
    link_to(text, object) unless object.nil?
  end
end
