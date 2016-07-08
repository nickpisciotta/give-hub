module ChargesHelper
  include ActionView::Helpers::NumberHelper

  def format_price(amount)
    number_to_currency(amount)
  end
end
