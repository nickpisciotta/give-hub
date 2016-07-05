require 'rails_helper'

RSpec.feature  "recipient list show correct items needed when donations made" do
  scenario "item removed when fully donated" do
    user = create(:user)
    need_item = create(:future_need_item_multiple)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit charity_recipient_path(need_item.charity.slug, need_item.recipient)

    expect(page).to have_content("#{need_item.name}")

    select  10, from: "need_item[quantity]"
    click_on "add to cart"

    visit cart_index_path
    click_on "Checkout"
    click_on "Confirm Donation"
    visit charity_recipient_path(need_item.charity.slug, need_item.recipient)

    expect(page).to_not have_content("#{need_item.name}")
  end

  scenario "selector reduced when partially donated" do
    need_item = create(:future_need_item_multiple)

    donation_item = DonationItem.create(quantity: 8, need_item_id: need_item.id, donation: create(:donation))

    visit charity_recipient_path(need_item.charity.slug, need_item.recipient)

    expect(page).to have_select("need_item[quantity]", options: ["1", "2"])
    expect(page).to_not have_select("need_item[quantity]",
      options: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"])
  end
end
