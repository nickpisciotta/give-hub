require 'rails_helper'

RSpec.describe DonationItem, type: :model do
  it {should belong_to(:donation)}
  it {should belong_to(:need_item)}


  it "outputs need name of donation_item" do
    create_list(:status, 3)
    donation_item = create(:donation_item)

    expect(donation_item.name).to eq(donation_item.need_item.need.name)
  end

  it "returns correct unit price" do
    create_list(:status, 3)
    donation_item = create(:donation_item)

    expect(donation_item.unit_price).to eq(donation_item.need_item.need.price)
  end

  it "returns correct item subtotal" do

    create_list(:status, 3)
    donation_item = DonationItem.create(quantity: 7, need_item: create(:need_item))

    expect(donation_item.subtotal).to eq(7.0 * donation_item.unit_price)
  end

  it "returns correct total items" do

    create_list(:status, 3)
    DonationItem.create(quantity: 7, need_item: create(:need_item))
    DonationItem.create(quantity: 3, need_item: create(:need_item))

    expect(DonationItem.total_items).to eq(10)
  end
end
