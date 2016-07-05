require 'rails_helper'

RSpec.feature "User Can View the Recipients Based on their Need" do
  scenario "User navigates to recipient from needs" do
    need_item = create(:future_need_item)
    need_category = need_item.need.needs_category
    recipient = need_category.recipients.first

    visit root_path
    within '.needs-list' do
      click_on need_category.name
    end

    expect(current_path).to eq(needs_category_path(need_category.slug))

    expect(page).to have_content(recipient.name)
    expect(page).to have_content(recipient.description)

    click_on "#{recipient.name}"

    expect(current_path).to eq(charity_recipient_path(recipient.charity.slug, recipient))
  end

end
