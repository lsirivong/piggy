module ApplicationHelper
  def formatted_date date
    date.strftime("%b %d")
  end
end
