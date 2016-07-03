require 'rails_helper'

RSpec.feature "admin can see individual donation associated with charity" do
  scenario "business admin can see donation" do

    role = Role.create(name: 'business_admin')
    user = create(:user)
    charity = create(:charity)
    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))
    donation_item = charity.needs.first.donation_items.create()
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_needs_path(charity.slug)
    within ".#{need1.name}" do
      click_on "View Details"
    end

    expect(current_path).to eq(admin_charity_need_path(charity.slug, need1))

    expect(page).to have_content("#{need1.name}")
    expect(page).to have_content("#{need1.description}")
    expect(page).to have_content("#{need1.price}")
    expect(page).to have_content("#{need1.needs_category.name}")
    expect(page).to have_content("Active")
    expect(page).to have_link("Deactivate")

  end
