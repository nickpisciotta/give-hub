require 'rails_helper'

RSpec.feature "admin can see all needs for charity" do
  scenario "business admin can see all needs" do

    role = Role.find_by(name: 'Business Admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    create(:status)

    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))
    need2 = charity.needs.create(name: "Need-2", description: "description for Need-2", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_dashboard_path(charity.slug)

    click_on "Manage Needs"
    expect(current_path).to eq(admin_charity_needs_path(charity.slug))
    expect(page).to have_content("#{need1.name}")
    expect(page).to have_content("#{need2.name}")

  end

  scenario "business owner can see all needs" do

    role = Role.find_by(name: 'Business Owner')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    create(:status)

    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))
    need2 = charity.needs.create(name: "Need-2", description: "description for Need-2", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_dashboard_path(charity.slug)

    click_on "Manage Needs"
    expect(current_path).to eq(admin_charity_needs_path(charity.slug))
    expect(page).to have_content("#{need1.name}")
    expect(page).to have_content("#{need2.name}")

  end

  scenario "business owner cannot see needs of other charity" do

    role = Role.find_by(name: 'Business Owner')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    charity_two = create(:charity)
    create(:status)

    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))
    need2 = charity.needs.create(name: "Need-2", description: "description for Need-2", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_dashboard_path(charity_two.slug)

    expect(page).to have_content("not authorized")
    expect(current_path).to eq(root_path)

  end

  scenario "business admin cannot see needs of other charity" do

    role = Role.find_by(name: 'Business Admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    charity_two = create(:charity)
    create(:status)

    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))
    need2 = charity.needs.create(name: "Need-2", description: "description for Need-2", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_dashboard_path(charity_two.slug)

    expect(page).to have_content("not authorized")
    expect(current_path).to eq(root_path)

  end

  scenario "platform admin can see needs of any charity" do

    role = Role.find_by(name: 'Platform Admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id)
    create(:status)

    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))
    need2 = charity.needs.create(name: "Need-2", description: "description for Need-2", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_dashboard_path(charity.slug)

    click_on "Manage Needs"

    expect(current_path).to eq(admin_charity_needs_path(charity.slug))
    expect(page).to have_content("#{need1.name}")
    expect(page).to have_content("#{need2.name}")

  end


  scenario "reg user cannot see charity needs" do

    role = Role.find_by(name: 'Registered User')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity: charity)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_needs_path(charity.slug)

    expect(page).to have_content("not authorized")
    expect(current_path).to eq(root_path)

  end
end
