require 'rails_helper'

RSpec.feature "admin can add user role" do
  scenario "platform admin adds user role" do
    platform_role = Role.create(name: 'platform_admin')
    bus_admin_role = Role.create(name: "business_admin")
    bus_owner_role = Role.create(name: "business_owner")
    reg_user_role= Role.create(name: "registered_user")
    admin, user = create_list(:user, 2)
    charity1, charity2 = create_list(:charity, 2)
    admin_role = UserRole.create(role_id: platform_role.id, user_id: admin.id)
    user_role = UserRole.create(role_id: reg_user_role.id, user_id: user.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    expect(user.user_roles.count).to eq(1)

    visit admin_dashboard_path

    click_on "Manage Users"

    within(".#{user.username}") do
      click_on "Add Role"
    end

    expect(current_path).to eq(new_admin_user_user_role_path(User.find_by(username: "#{user.username}")))

    select "#{charity2.name}", from: "user_role[charity_id]"
    select "#{bus_owner_role .name}", from: "user_role[role_id]"

    click_on "Add User Role"

    expect(current_path).to eq(admin_user_path(User.find_by(username: user.username)))
    expect(page).to have_content("business_owner")
    expect(user.user_roles.count).to eq(2)
  end

end
