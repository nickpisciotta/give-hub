require 'rails_helper'

RSpec.describe AnalyticsPresenter, type: :model do
  # it "can calculate the total funds from donations" do
  #   donation_item = create(:donation_item)
  #   charity = donation_item.need_item.need.charity
  #   analytics_presenter = AnalyticsPresenter.new(charity)
  #
  #   expect(analytics_presenter.donation_total).to eq(10)
  # end

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

  # it "can calculate total funds from donations for each day" do
  #
  # end
  #
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
