require 'rails_helper'

RSpec.feature "User Adds Need To Carts" do
  scenario "cart has need that user added for one charities recipient" do

    item = create(:future_need_item)
    recipient = item.recipient
    charity = recipient.charity

    visit charity_recipient_path(charity.slug, recipient)

    within(".#{item.name}") do
      select  1, from: "need_item[quantity]"
      find(:button, "add to cart").click
    end

    visit cart_index_path

    expect(page).to have_content("#{item.name}")
  end


  scenario "cart has need that user added for multiple charities recipients" do

    charity_one, charity_two = create_list(:charity, 2)
    charity_one.update_attribute(:status_id, 1)
    charity_two.update_attribute(:status_id, 1)
    recipient_one = charity_one.recipients.create(name: "rec1", description: "test1")
    recipient_two = charity_two.recipients.create(name: "rec2", description: "test1")
    item_one = recipient_one.need_items.create(quantity: 2, need: create(:need), deadline: 5.days.from_now)
    item_two = recipient_two.need_items.create(quantity: 8, need: create(:need), deadline: 5.days.from_now)

    visit charity_recipient_path(charity_one.slug, recipient_one)

    within(".#{item_one.name}") do
      select  1, from: "need_item[quantity]"
      find(:button, "add to cart").click
    end

    visit charity_recipient_path(charity_two.slug, recipient_two)

    within(".#{item_two.name}") do
      select  1, from: "need_item[quantity]"
      find(:button, "add to cart").click
    end

    visit cart_index_path

    within ".cart-table" do
      expect(page).to have_content("#{item_one.name}")
      expect(page).to have_content("#{item_two.name}")
      click_on "#{recipient_one.charity.name}"
    end

    expect(current_path).to eq(charity_path(recipient_one.charity.slug))

    visit cart_index_path
    click_on "#{item_two.name}"
    expect(current_path).to eq(charity_recipient_path(charity_two.slug, recipient_two))

  end
end
