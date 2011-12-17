module ApplicationHelper
  def formatted_date date
    date.strftime("%b %d")
  end
  
  def formatted_money value
    format "$%#.2f", value
  end
end
