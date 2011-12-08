module FormatHelper
  def financial_format(value)
    if value < 0
      value = value * -1
      "(#{(value)})"
    else
      "#{value}"
    end 
  end
end