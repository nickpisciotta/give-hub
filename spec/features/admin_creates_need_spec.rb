require 'rails_helper'

RSpec.feature "admin can add need for charity" do
  scenario "business admin can add need" do

    role = Role.find_by(name: 'Business Admin')
    user = create(:user)
    charity = create(:charity)
    status = create(:status)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    need_cat1, need_cat2 = create_list(:needs_category, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    expect(charity.needs.count).to eq(0)

    visit admin_charity_needs_path(charity.slug)

    click_on "Add Need"

    expect(current_path).to eq(new_admin_charity_need_path(charity.slug))
    fill_in "Name", with: "Need-1"
    fill_in "Description", with: "description for Need-1"
    fill_in "Price", with: 10
    select "#{need_cat1.name}", from: "need[needs_category_id]"
    click_on "Create Need"
    expect(current_path).to eq(admin_charity_need_path(charity.slug, Need.first))
    expect(page).to have_content("Need-1")
    expect(page).to have_content("description for Need-1")
    expect(page).to have_content("10")
    expect(page).to have_content("#{need_cat1.name}")

    expect(need_cat1.needs.first).to eq(Need.first)
    expect(charity.needs.count).to eq(1)

  end

  scenario "business owner can a need" do

    role = Role.find_by(name: 'Business Owner')
    user = create(:user)
    charity = create(:charity)
    status = create(:status)

    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    need_cat1, need_cat2 = create_list(:needs_category, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_needs_path(charity.slug)

    click_on "Add Need"

    expect(current_path).to eq(new_admin_charity_need_path(charity.slug))

    fill_in "Name", with: "Need-1"
    fill_in "Description", with: "description for Need-1"
    fill_in "Price", with: 10
    select "#{need_cat1.name}", from: "need[needs_category_id]"
    click_on "Create Need"


    expect(current_path).to eq(admin_charity_need_path(charity.slug, Need.first))

    expect(page).to have_content("Need-1")
    expect(page).to have_content("description for Need-1")
    expect(page).to have_content("10")
    expect(page).to have_content("#{need_cat1.name}")

    expect(need_cat1.needs.first).to eq(Need.first)

  end

  scenario "business owner cannot create need for other charity" do

    role = Role.find_by(name: 'Business Owner')
    user = create(:user)
    charity_one, charity_two = create_list(:charity, 2)

    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity_one.id)
    need_cat1, need_cat2 = create_list(:needs_category, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit new_admin_charity_need_path(charity_two.slug)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("not authorized")

  end

  scenario "business admin cannot create need for other charity" do

    role = Role.find_by(name: 'Business Admin')
    user = create(:user)
    charity_one, charity_two = create_list(:charity, 2)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity_one.id)
    need_cat1, need_cat2 = create_list(:needs_category, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit new_admin_charity_need_path(charity_two.slug)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("not authorized")

  end

  scenario "platform admin can create need for charity" do

    role = Role.find_by(name: 'Platform Admin')
    user = create(:user)
    charity = create(:charity)
    status = create(:status)

    user_role = UserRole.create(role_id: role.id, user_id: user.id)
    need_cat1, need_cat2 = create_list(:needs_category, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_needs_path(charity.slug)

    click_on "Add Need"

    expect(current_path).to eq(new_admin_charity_need_path(charity.slug))

    fill_in "Name", with: "Need-1"
    fill_in "Description", with: "description for Need-1"
    fill_in "Price", with: 10
    select "#{need_cat1.name}", from: "need[needs_category_id]"
    click_on "Create Need"

    expect(current_path).to eq(admin_charity_need_path(charity.slug, Need.first))

    expect(page).to have_content("Need-1")
    expect(page).to have_content("description for Need-1")
    expect(page).to have_content("10")
    expect(page).to have_content("#{need_cat1.name}")

    expect(need_cat1.needs.first).to eq(Need.first)

  end


  scenario "reg user cannot create need" do

    role = Role.find_by(name: 'Registered User')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity: charity)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit new_admin_charity_need_path(charity.slug)

    expect(page).to have_content("not authorized")
    expect(current_path).to eq(root_path)

  end
end
