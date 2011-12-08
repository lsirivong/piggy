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
end
