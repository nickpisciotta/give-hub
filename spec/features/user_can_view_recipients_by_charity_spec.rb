require 'rails_helper'

RSpec.feature "User Can View the Recipients by Charity" do
  scenario "user navigates to recipients from root" do

  recipient_one = create(:future_need_item).recipient
  charity = recipient_one.charity
  charity.update_attribute(:status_id, 1)

  visit charities_path

  expect(page).to have_content("All Charities")
  within('.charity-list') do
    click_on "#{recipient_one.charity.name}"
  end

  expect(current_path).to eq(charity_path(recipient_one.charity.slug))

  expect(page).to have_content(recipient_one.name)
  expect(page).to have_content(recipient_one.description)

  click_on "#{recipient_one.name}"
  expect(current_path).to eq(charity_recipient_path(recipient_one.charity.slug, recipient_one))
  end

  scenario "user cannot forcibly see a recipient from anotoher charity through charity's slug" do

    charity_one, charity_two = create_list(:charity, 2)
    other_recipient = charity_two.recipients.create(name: "test", description: "test")

    visit "#{charity_one.slug}/recipients/#{other_recipient.id}"

    expect(current_path).to_not eq(charity_recipient_path(charity_one.slug, other_recipient))
  end

end
