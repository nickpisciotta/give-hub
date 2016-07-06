require 'rails_helper'

RSpec.feature "user can create an inactive charity for approval and is assigned business owner role" do
  scenario "user creates a charity" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    cause1, cause2 = create_list(:cause, 2)
    visit root_path
    click_on "Add Your Charity"

    expect(current_path).to eq(new_charity_path)
    fill_in "Name", with: "New Charity"
    fill_in "Tagline", with: "New Charity Tagline"
    fill_in "Description", with: "New Charity Description"
    expect(page).to have_select("causes_charities[cause_id]", options: [cause1.name, cause2.name])
    select cause1.name, from: "causes_charities[cause_id]"

    click_on "Submit Charity"

    expect(current_path).to eq(dashboard_path)
    charity = Charity.find_by(name: "New Charity")
    expect(page).to have_link("Admin Dashboard")
    click_on "Charity Dashboard"

    expect(current_path).to eq(admin_charity_dashboard_path(charity.slug))
    expect(page).to have_content("New Charity")
    expect(page).to have_content(cause1.name)
    expect(page).to have_content("Inactive")

  end

  scenario "inactive charity is not available to user" do

    user = create(:user)
    cause1, cause2 = create_list(:cause, 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit new_charity_path
    fill_in "Name", with: "Another Charity"
    fill_in "Tagline", with: "New Charity Tagline"
    fill_in "Description", with: "New Charity Description"

    select cause1.name, from: "causes_charities[cause_id]"
    click_on "Submit Charity"

    charity = Charity.find_by(name: "Another Charity")

    expect(charity.status.name).to eq("Inactive")
    visit charity_path(charity)
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Sorry, it seems that is not an active charity.")

  end

end
