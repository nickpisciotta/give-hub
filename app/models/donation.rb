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

  def self.stats
    num_items = DonationItem.total_items
    num_families = Family.count
    money_raised =  Donation.all.reduce(0) do |sum, donation|
      sum += donation.total
    end
    {num_items: num_items, num_families: num_families, money_raised: money_raised.to_f}
  end

  def self.form_options(user)
    if user.platform_admin?
      all.map{ |donation| [ donation.name, donation.id ] }
    else
      user.charities.map{ |charity| }
    end
  end

end
