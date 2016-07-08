class AnalyticsPresenter

  def initialize(charity)
    @charity = charity
  end

  def donation_total
    donation_totals = @charity.donations.map {|donation| donation.total.to_i}
    donors = @charity.donations.map {|donation| donation.user.username}
    [donation_totals, donors]
  end

  def need_by_category
    category_names = @charity.needs.map {|need| need.needs_category.name}
    category_count_hash = category_names.each_with_object(Hash.new(0)) { |category, counts| counts[category] += 1}
    [category_count_hash.values, category_count_hash.keys]
  end

  def total_donations_by_day
    donation_dates = @charity.donations.map {|donation| donation.created_at.strftime("%B %d, %Y")}
    donation_dates_hash = donation_dates.each_with_object(Hash.new(0)) { |date, counts| counts[date] += 1}
    [donation_dates_hash.values, donation_dates_hash.keys]
  end

  def recipient_need_totals
    need_item_count = @charity.recipients.map {|recipient| recipient.need_items.count}
    recipients = @charity.recipients.pluck(:name)
    [need_item_count, recipients]
  end
end
