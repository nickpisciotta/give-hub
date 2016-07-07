class NeedItem < ActiveRecord::Base

  belongs_to :need
  belongs_to :recipient
  has_many :donation_items
  has_many :donations, through: :donation_items
  scope :retired, -> {where("deadline < ?", Date.today)}
  scope :active, -> {where("deadline > ?", Date.today)}

  def active_need_item
    if deadline
      deadline > Date.today && quantity_remaining > 0
    else
      quantity_remaining > 0
    end
  end

  def name
    need.name
  end

  def description
    need.description
  end

  def price
    need.price
  end


  def charity
    recipient.charity
  end

  def quantity_remaining
    quantity - donation_items.sum(:quantity)
  end

  def subtotal(quantity)
    price * quantity
  end
end
