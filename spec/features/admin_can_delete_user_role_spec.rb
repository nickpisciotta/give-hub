require 'rails_helper'

RSpec.feature "admin can delete user role" do
  scenario "business owner deletes a business admin user role for their charity" do
    platform_role = Role.find_by(name: 'Platform Admin')
    bus_admin_role = Role.find_by(name: "Business Admin")
    bus_own_role = Role.find_by(name: "Business Owner")
    reg_user_role = Role.find_by(name: "Registered User")
    bus_owner, bus_admin = create_list(:user, 2)
    charity = create(:charity)

    bus_owner.user_roles.create(role_id: bus_own_role.id, charity_id: charity.id)
    target_role = bus_admin.user_roles.create(role_id: bus_admin_role.id, charity_id: charity.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(bus_owner)

    expect(charity.users.count).to eq(2)
    visit admin_users_path

    within(".charity-#{bus_admin.username}") do
      expect(page).to_not have_content("Registered User")
      click_on "Delete Role"
    end

    expect(current_path).to eq(admin_users_path)
    visit (admin_user_path(bus_admin))

    expect(page).to_not have_content(bus_admin_role.name)
    expect(page).to have_content("No Roles for Your Charity")
    expect(charity.users.count).to eq(1)

  end

  scenario "business owner cannot delete a business admin user role for another charity" do

    platform_role = Role.find_by(name: 'Platform Admin')
    bus_admin_role = Role.find_by(name: "Business Admin")
    bus_own_role = Role.find_by(name: "Business Owner")
    reg_user_role = Role.find_by(name: "Registered User")
    bus_owner, bus_admin = create_list(:user, 2)
    charity, other_charity = create_list(:charity, 2)
    bus_owner.user_roles.create(role_id: bus_own_role.id, charity_id: charity.id)
    bus_admin.user_roles.create(role_id: bus_admin_role.id, charity_id: other_charity.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(bus_owner)

    visit admin_users_path

    within(".#{charity.name}") do
      expect(page).to_not have_content(bus_admin.username)
    end

    within(".#{bus_admin.username}") do
      click_on "View"
    end

    expect(current_path).to eq(admin_user_path(bus_admin))

    expect(page).to_not have_content(bus_admin_role.name)
    expect(page).to have_content("No Roles for Your Charity")
    expect(page).to_not have_content("Delete Role")


  end

  scenario "platform admin can delete a user role for anyone" do
    platform_role = Role.find_by(name: 'Platform Admin')
    bus_admin_role = Role.find_by(name: "Business Admin")
    bus_own_role = Role.find_by(name: "Business Owner")
    reg_user_role = Role.find_by(name: "Registered User")
    platform_admin, bus_admin = create_list(:user, 2)
    charity = create(:charity)
    platform_admin.user_roles.create(role_id: platform_role.id)
    bus_admin.user_roles.create(role_id: bus_own_role.id, charity_id: charity.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(platform_admin)

    visit admin_users_path
    expect(charity.users.count).to eq(1)

    within(".#{charity.name}") do
      expect(page).to have_content(bus_admin.username)
      click_on "Delete Role"
    end

    expect(current_path).to eq(admin_users_path)
    visit (admin_user_path(bus_admin))

    expect(page).to_not have_content(bus_admin_role.name)
    expect(page).to have_content("No Roles for Your Charity")
    expect(charity.users.count).to eq(0)

  end

end
