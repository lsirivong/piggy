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
    
    budget = envelope.budget
    out = fade_change("#budget_remaining .value", budget.remaining)
    out << fade_change("#budget_spent .value", budget.spent.abs)
  
    budget_over_wrap_selector = "#budget_spent .amount_over_wrap"
    out << set_amount_over_visibility(budget.spent_too_much, budget_over_wrap_selector)
    
    out << fade_change("#budget_spent .amount_over", budget.amount_over)
    
    out << fade_change("##{dom_id envelope} .remaining .value", envelope.remaining.abs)
    out << fade_change("##{dom_id envelope} .spent .value", envelope.spent.abs)
  
    out << fade_change("##{dom_id envelope} .spent .amount_over", envelope.amount_over)
    
    envelope_over_wrap_selector = "##{dom_id envelope} .spent .amount_over_wrap"
    out << set_amount_over_visibility(envelope.spent_too_much, envelope_over_wrap_selector)
    
    goal = transaction.goal
    unless goal.nil?
      out << fade_change("##{dom_id goal} .saved .value", goal.total)
      out << fade_change("##{dom_id goal} .remaining .value", goal.remaining)
    end
    
    return out
  end
  
  def link_to_unless_nil(text, object)
    link_to(text, object) unless object.nil?
  end
  
  private
  
  def set_amount_over_visibility(spent_too_much, sel)
    if spent_too_much
      return show_if_hidden(sel)
    else
      return hide_if_shown(sel)
    end
  end
  
  def show_if_hidden(sel)
    "if ($('#{sel}').is('.hidden')) { $('#{sel}').removeClass('hidden'); }"
  end
  
  def hide_if_shown(sel)
    "if (!$('#{sel}').is('.hidden')) { $('#{sel}').addClass('hidden'); }"
  end
  
  def fade_change(selector, value)
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
    
    return animate % [selector, "#{financial_format value}"]
  end
  
end
