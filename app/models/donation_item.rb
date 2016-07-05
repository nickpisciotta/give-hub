class DonationItem < ActiveRecord::Base
  belongs_to :need_item
  belongs_to :donation

  def name
    need_item.need.name
  end

  def unit_price
    need_item.need.price
  end

  def subtotal
    unit_price * quantity
  end

  def self.total_items
    sum(:quantity)
  end
end
