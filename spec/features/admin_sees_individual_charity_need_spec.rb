require 'rails_helper'

RSpec.feature "admin can see individual need for charity" do
  scenario "business admin can see need" do

    role = Role.find_by(name: 'Business Admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    status = Status.create(name: "Active")

    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

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

  scenario "business owner can see a need" do

    role = Role.find_by(name: 'Business Owner')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    status = Status.create(name: "Active")

    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

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

  scenario "business owner cannot see need of other charity" do

    role = Role.find_by(name: 'Business Owner')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    charity_two = create(:charity)
    status = Status.create(name: "Active")

    need1 = charity_two.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_need_path(charity_two, need1)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("not authorized")


  end

  scenario "business admin cannot see needs of other charity" do

    role = Role.find_by(name: 'Business Admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    charity_two = create(:charity)
    status = Status.create(name: "Active")

    need1 = charity_two.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_need_path(charity_two, need1)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("not authorized")

  end

  scenario "platform admin can see needs of any charity" do

    role = Role.find_by(name: 'Platform Admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id)
    status = Status.create(name: "Active")

    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_needs_path(charity.slug)

    within ".#{need1.name}" do
      click_on "View Details"
    end

    expect(current_path).to eq(admin_charity_need_path(charity.slug, need1))

    expect(page).to have_content("#{need1.name}")
    expect(page).to have_content("Active")
    expect(page).to have_link("Suspend")

  end


  scenario "reg user cannot see charity needs" do

    role = Role.find_by(name: 'Registered User')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity: charity)
    status = Status.create(name: "Active")
    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_need_path(charity.slug, need1)

    expect(page).to have_content("not authorized")
    expect(current_path).to eq(root_path)

  end
end
