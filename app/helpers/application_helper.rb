module ApplicationHelper
  def formatted_date date
    date.strftime("%b %d")
  end
  
  def link_to_edit_transaction(name, transaction)
    fields = transaction_form transaction, :show_cancel => true, :show_labels => false

    li = content_tag(:li, fields, :id => dom_id(transaction))

    link_to_function(name, "add_fields_to_edit_transaction('#{dom_id(transaction)}', '#{escape_javascript(li)}')", :href => edit_transaction_path(transaction))
  end
  
  def recalculate_stats(transaction)
    envelope = transaction.envelope
    out = ""
    out << set_ledger_stats("#{dom_id envelope}", envelope)
    
    budget = envelope.budget
    out << set_ledger_stats("budget", budget)
    
    budget_over_wrap_selector = "#budget_spent .amount_over_wrap"
    out << set_amount_over_visibility(budget_over_wrap_selector, budget)
    envelope_over_wrap_selector = "##{dom_id envelope} .spent .amount_over_wrap"
    out << set_amount_over_visibility(envelope_over_wrap_selector, envelope)
    
    goal = transaction.goal
    if goal.present?
      out << fade_change("##{dom_id goal} .saved .value", goal.total)
      out << fade_change("##{dom_id goal} .remaining .value", goal.remaining)
    end
    
    return out
  end
  
  def link_to_unless_nil(text, object)
    link_to(text, object) if object.present?
  end
  
  private
  
  def set_ledger_stats(sel_prefix, ledger)
    out = fade_change("##{sel_prefix}_remaining_value", ledger.remaining)
    out << fade_change("##{sel_prefix}_spent_value", ledger.spent)
    out << fade_change("##{sel_prefix}_spent_over_value", ledger.amount_over)
  end
  
  def set_amount_over_visibility(sel, ledger)
    if ledger.spent_over?
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
    animate = "$('%s').animate({ opacity: 0 }, 350,
      function() { $(this).html('%s').animate( { opacity: 1 }, 350); }
    );"
    
    return animate % [selector, "#{financial_format value}"]
  end
  
end
