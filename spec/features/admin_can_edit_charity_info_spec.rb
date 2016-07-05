require 'rails_helper'

RSpec.feature "admin can edit details of charity" do
  scenario "platform admin can edit charity information" do

    role = Role.find_by(name: 'Platform Admin')
    user = create(:user)
    user_role = UserRole.create(role_id: role.id, user_id: user.id)
    Status.create(name: 'Active')
    Status.create(name: 'Inactive')
    charity = create(:charity)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_dashboard_path(charity.slug)

    click_on "Update Charity"

    expect(current_path).to eq(edit_admin_charity_charity_path(charity.slug, charity))

    fill_in 'charity[name]', with: "New Name"
    fill_in 'charity[description]', with: "New Description for Charity"
    expect(page).to have_css("input#charity_charity_photo")

    click_on "Save Changes"

    expect(current_path).to eq(admin_dashboard_path)

    expect(page).to have_content("New Name")
    visit admin_charity_dashboard_path(charity.slug)

    expect(page).to have_content("New Description for Charity")
  end



  scenario "business owner can edit charity information" do

    role = Role.find_by(name: 'Business Owner')
    user = create(:user)
    Status.create(name: 'Active')
    Status.create(name: 'Inactive')
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_dashboard_path(charity.slug)

    click_on "Update Charity"

    expect(current_path).to eq(edit_admin_charity_charity_path(charity.slug, charity))

    fill_in 'charity[name]', with: "New Name"
    fill_in 'charity[description]', with: "New Description for Charity"
    expect(page).to have_css("input#charity_charity_photo")

    click_on "Save Changes"

    expect(current_path).to eq(admin_charity_dashboard_path(charity.slug))

    expect(page).to have_content("New Name")
    expect(page).to have_content("New Description for Charity")
  end

  scenario "business admin can edit charity information" do

    role = Role.find_by(name: 'Business Admin')
    user = create(:user)
    Status.create(name: 'Active')
    Status.create(name: 'Inactive')
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_dashboard_path(charity.slug)

    click_on "Update Charity"

    expect(current_path).to eq(edit_admin_charity_charity_path(charity.slug, charity))

    fill_in 'charity[name]', with: "New Name"
    fill_in 'charity[description]', with: "New Description for Charity"
    expect(page).to have_css("input#charity_charity_photo")

    click_on "Save Changes"

    expect(current_path).to eq(admin_charity_dashboard_path(charity.slug))

    expect(page).to have_content("New Name")
    expect(page).to have_content("New Description for Charity")

  end

end
