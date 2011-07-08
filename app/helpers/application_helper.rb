module ApplicationHelper
  def markdown(text)
    RDiscount.new(text, :smart, :autolink, :filter_html).to_html.html_safe
  end
end
