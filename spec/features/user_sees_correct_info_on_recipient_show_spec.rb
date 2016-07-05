#STILL NEEDED - pending these routes
# The visitor can click on any of the following buttons:
# See all recipients for [this charity]
# See all recipients for [this cause]
# See all recipients for [this type of need]


require 'rails_helper'

RSpec.feature "user sees correct info for recipients" do

  scenario "they see a form for recipients that have active need items" do
    item1 = create(:future_need_item)
    recipient = item1.recipient
    charity = recipient.charity
    charity.update_attribute(:status_id, 1)
    item2 = recipient.need_items.create!(quantity: 2, deadline: 10.days.from_now, need: create(:need))

    visit charity_recipient_path(charity.slug, recipient)
    within (".recipient-info") do
      expect(page).to have_content(recipient.name)
      expect(page).to have_content(recipient.description)
    end

    within (".charity-info") do
      expect(page).to have_content(recipient.charity.name)
      expect(page).to have_content(recipient.charity.description)
    end

    within(".current-needs") do
      within(".#{item1.name}") do
        expect(page).to have_content(item1.name)
        expect(page).to have_content(item1.description)
        expect(page).to have_content(item1.need.price)
        expect(page).to have_button("add to cart")
        expect(page).to have_select('need_item[quantity]', :options => ['1'])
      end

      within(".#{item2.name}") do
        expect(page).to have_content(item2.name)
        expect(page).to have_content(item2.description)
        expect(page).to have_content(item2.need.price)
        expect(page).to have_button("add to cart")
        expect(page).to have_select('need_item[quantity]', :options => ['1', '2'])
      end
    end
  end

  scenario "fully donated items are not shown as active need items" do
    item1 = create(:future_need_item)
    recipient = item1.recipient
    charity = recipient.charity
    item2 = recipient.need_items.create!(quantity: 2, deadline: 10.days.from_now, need: create(:need))
    item2.donation_items.create!(quantity: 2, donation: create(:donation))

    visit charity_recipient_path(charity.slug, recipient)

    within (".recipient-info") do
      expect(page).to have_content(recipient.name)
      expect(page).to have_content(recipient.description)
    end

    within (".charity-info") do
      expect(page).to have_content(recipient.charity.name)
      expect(page).to have_content(recipient.charity.description)
    end

    within(".current-needs") do
      within(".#{item1.name}") do
        expect(page).to have_content(item1.name)
        expect(page).to have_content(item1.description)
        expect(page).to have_content(item1.need.price)
        expect(page).to have_button("add to cart")
        expect(page).to have_select('need_item[quantity]', :options => ['1'])
      end
      expect(page).to_not have_selector(".#{item2.name}")
      expect(page).to_not have_content(item2.name)
      expect(page).to_not have_content(item2.description)
    end
  end


  scenario "they see a form for recipients that have active need items and inactive items are not shown" do
    item1 = create(:future_need_item)
    recipient = item1.recipient
    charity = recipient.charity
    item2 = recipient.need_items.create!(quantity: 2, deadline: 10.days.ago, need: create(:need))

    visit charity_recipient_path(charity.slug, recipient)

    within(".current-needs") do
      within(".#{item1.name}") do
        expect(page).to have_content(item1.name)
        expect(page).to have_content(item1.description)
        expect(page).to have_content(item1.need.price)
        expect(page).to have_button("add to cart")
        expect(page).to have_select('need_item[quantity]', :options => ['1'])
      end
    end

    expect(page).to_not have_content(item2.name)
    expect(page).to_not have_content(item2.description)

  end

  scenario "they don't see a form for recipients with no active needs" do
    item1 = create(:past_need_item)
    recipient = item1.recipient
    charity = recipient.charity

    visit charity_recipient_path(charity.slug, recipient)

    expect(page).to_not have_content(item1.name)
    expect(page).to_not have_content(item1.description)
    expect(page).to have_content("has no current donation needs")

  end

    scenario "they don't see a recipient for another charity through the charity path" do
      charity, other_charity = create_list(:charity, 2)
      charity.update_attribute(:status_id, 1)
      other_charity.update_attribute(:status_id, 1)

      other_recipient = other_charity.recipients.create(name: "test", description: "test")

      visit charity_recipient_path(charity.slug, other_recipient)

      expect(current_path).to eq(charity_path(charity.slug))
      expect(page).to have_content("Recipient not found")

    end

end
