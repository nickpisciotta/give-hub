require 'rails_helper'

RSpec.feature "user sees past donation" do
  scenario "donation page is shown for authenticated user" do
    donation, other_users_donation = create_list(:donation, 2)
    user = User.find(donation.user_id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit donations_path
    click_on(donation.id)
    expect(current_path).to eq(donation_path(donation))

    expect(page).to have_content("Donation #{donation.id}")
  end
end
