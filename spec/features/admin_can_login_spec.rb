require 'rails_helper'

RSpec.feature "admin can login" do
  scenario "platform admin logs in and sees the admin dashboard" do
    user = create(:user)
    role = Role.find_by(name: 'Platform Admin')
    user_role = role.user_roles.create(user_id: user.id)


    visit login_path

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_on "Login to Account"

    expect(page).to have_content "Dashboard"
    expect(page).to have_content "Manage Users"
  end

  scenario "business admin ogs in and sees the admin dashboard" do
    user = create(:user)
    role = Role.find_by(name: 'Business Admin')
    user_role = role.user_roles.create(user_id: user.id)


    visit login_path

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_on "Login to Account"

    expect(page).to have_content "Dashboard"
    expect(page).to have_content "Manage Users"
  end

  scenario "regular user cannot access admin dashboard and sees not authorized" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_dashboard_path

    expect(page).to have_content "not authorized"
  end

  scenario "unregistered cannot access admin dashboard and sees not authorized" do
    visit admin_dashboard_path

    expect(page).to have_content "not authorized"
  end
end
