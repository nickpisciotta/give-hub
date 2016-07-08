class Donation < ActiveRecord::Base
  belongs_to :user
  has_many :donation_items
  has_many :needs

  def date
    created_at.to_date
  end

  def total
    donation_items.reduce(0) do |sum, item|
      sum += item.subtotal
    end
  end

end
