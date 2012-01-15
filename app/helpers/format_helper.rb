module FormatHelper
  def financial_format(value)
    number_to_currency(value, :negative_format => "(%u%n)")
  end
end