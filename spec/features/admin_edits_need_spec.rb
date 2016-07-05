require 'rails_helper'

RSpec.feature "admin can edit need for charity" do
  scenario "business admin can edit need" do

    role = Role.find_by(name: 'Business Admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    create(:status)
    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_needs_path(charity.slug)

    within ".#{need1.name}" do
      click_on "Update"
    end

    expect(current_path).to eq(edit_admin_charity_need_path(charity.slug, need1))

    fill_in "Name", with: "Need-1-New"
    fill_in "Description", with: "New description for Need-1"
    fill_in "Price", with: 15
    click_on "Update Need"

    expect(current_path).to eq(admin_charity_need_path(charity.slug, Need.first))

    expect(page).to have_content("Need-1-New")
    expect(page).to have_content("New description for Need-1")
    expect(page).to have_content("15")

  end

  scenario "business owner can edit a need" do

    role = Role.find_by(name: 'Business Owner')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    create(:status)
    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_needs_path(charity.slug)

    within ".#{need1.name}" do
      click_on "Update"
    end

    expect(current_path).to eq(edit_admin_charity_need_path(charity.slug, need1))

    fill_in "Name", with: "Need-1-New"
    fill_in "Description", with: "New description for Need-1"
    fill_in "Price", with: 15
    click_on "Update Need"

    expect(current_path).to eq(admin_charity_need_path(charity.slug, Need.first))

    expect(page).to have_content("Need-1-New")
    expect(page).to have_content("New description for Need-1")
    expect(page).to have_content("15")

  end

  scenario "business owner cannot edit need for other charity" do

    role = Role.find_by(name: 'Business Owner')
    user = create(:user)
    charity_one, charity_two = create_list(:charity, 2)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity_one.id)

    need_cat1, need_cat2 = create_list(:needs_category, 2)
    create(:status)
    need1 = charity_one.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit edit_admin_charity_need_path(charity_two.slug, need1)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("not authorized")

  end

  scenario "business admin cannot create need for other charity" do

    role = Role.find_by(name: 'Business Admin')
    user = create(:user)
    charity_one, charity_two = create_list(:charity, 2)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity_one.id)
    need_cat1, need_cat2 = create_list(:needs_category, 2)
    create(:status)
    need1 = charity_two.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit edit_admin_charity_need_path(charity_two.slug, need1)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("not authorized")

  end

  scenario "platform admin can create need for charity" do

    role = Role.find_by(name: 'Platform Admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    create(:status)
    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_needs_path(charity.slug)

    within ".#{need1.name}" do
      click_on "Update"
    end

    expect(current_path).to eq(edit_admin_charity_need_path(charity.slug, need1))

    fill_in "Name", with: "Need-1-New"
    fill_in "Description", with: "New description for Need-1"
    fill_in "Price", with: 15
    click_on "Update Need"

    expect(current_path).to eq(admin_charity_need_path(charity.slug, Need.first))

    expect(page).to have_content("Need-1-New")
    expect(page).to have_content("New description for Need-1")
    expect(page).to have_content("15")


  end


  scenario "reg user cannot see charity needs" do

    role = Role.find_by(name: 'Registered User')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity: charity)
    need_cat1, need_cat2 = create_list(:needs_category, 2)
    create(:status)
    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit edit_admin_charity_need_path(charity.slug, need1)

    expect(page).to have_content("not authorized")
    expect(current_path).to eq(root_path)
  end
end
