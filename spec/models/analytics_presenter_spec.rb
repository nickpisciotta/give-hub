require 'rails_helper'

RSpec.describe AnalyticsPresenter, type: :model do
  it "can calculate the total funds from donations" do
    charity = Charity.create(name: "charity", tagline: "tagline", description: "description")
    user = User.create(username: "nick", password: "password", email: "www.email.com")
    needs_category = NeedsCategory.create(name: "category1", tagline: "tagline", description: "description")
    need = Need.create(name: "need", description: "description1", price: 10, needs_category_id: needs_category.id)
    recipient = Recipient.create(name: "Nick", description: "description", charity_id: charity.id)
    donation = Donation.create(user_id: user.id)
    need_items = NeedItem.create(deadline: Date.today, quantity: 20, recipient_id: recipient.id, need_id: need.id)
    donation_item = DonationItem.create(quantity: 10, donation_id: donation.id, need_item_id: need_items.id )

    analytics_presenter = AnalyticsPresenter.new(charity)

    expect(analytics_presenter.donation_total[0]).to eq([donation_item.quantity * need.price])
  end

  it "can count needs within each category" do
    need1 = create(:need)
    need2 = create(:need)
    charity1 = need1.charity
    charity2 = need2.charity
    analytics_presenter1 = AnalyticsPresenter.new(charity1)
    analytics_presenter2 = AnalyticsPresenter.new(charity2)

    expect(analytics_presenter1.need_by_category[0]).to eq([charity1.needs.count])
    expect(analytics_presenter1.need_by_category[1]).to eq([charity1.needs.first.needs_category.name])
    expect(analytics_presenter2.need_by_category[0]).to eq([charity2.needs.count])
    expect(analytics_presenter2.need_by_category[1]).to eq([charity2.needs.first.needs_category.name])
  end

  it "can calculate total funds from donations for each day" do
    charity = Charity.create(name: "charity", tagline: "tagline", description: "description")
    user = User.create(username: "nick", password: "password", email: "www.email.com")
    needs_category = NeedsCategory.create(name: "category1", tagline: "tagline", description: "description")
    need = Need.create(name: "need", description: "description1", price: 10, needs_category_id: needs_category.id)
    recipient = Recipient.create(name: "Nick", description: "description", charity_id: charity.id)
    donation = Donation.create(user_id: user.id)
    donation2 = Donation.create(user_id: user.id)
    need_items = NeedItem.create(deadline: Date.today, quantity: 20, recipient_id: recipient.id, need_id: need.id)
    donation_item = DonationItem.create(quantity: 10, donation_id: donation.id, need_item_id: need_items.id )
    donation_item2 = DonationItem.create(quantity: 10, donation_id: donation.id, need_item_id: need_items.id)
    analytics_presenter = AnalyticsPresenter.new(charity)

    expect(analytics_presenter.total_donations_by_day[0]).to eq([2])
  end

  it "calculates number of needs per recipient" do
    need_item1 = create(:future_need_item)
    need_item2 = create(:future_need_item)

    charity1 = need_item1.charity
    charity2 = need_item2.charity
    analytics_presenter1 = AnalyticsPresenter.new(charity1)
    analytics_presenter2 = AnalyticsPresenter.new(charity2)

    expect(analytics_presenter1.recipient_need_totals[0]).to eq([charity1.recipients.first.need_items.count])
    expect(analytics_presenter2.recipient_need_totals[0]).to eq([charity2.recipients.first.need_items.count])
  end

end
