require 'rails_helper'

RSpec.describe Donation, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:donation_items) }

  it "returns correct donation total" do
    create_list(:status, 3)
    donation_item = create(:donation_item)
    total = donation_item.donation.total.to_int
    price = donation_item.need_item.need.price

    expect(total).to eq(price)
  end

end
