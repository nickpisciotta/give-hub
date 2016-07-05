require 'rails_helper'

RSpec.feature "admin can change need status for charity" do
  scenario "business admin can change status to activated and deactivated but not suspended through index" do

    role = Role.find_by(name: 'Business Admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    create_list(:status, 3)
    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_needs_path(charity.slug)

    expect(page).to_not have_link("Suspend")

    within ".#{need1.name}" do
      click_on "Deactivate"
    end

    expect(current_path).to eq(admin_charity_need_path(charity.slug, need1))

    visit admin_charity_needs_path(charity.slug)

    within ".#{need1.name}" do

      expect(page).to have_link("Activate")

      expect(Need.first.status_id).to eq(2)
      expect(page).to_not have_link("Suspend")
      click_on("Activate")
    end

    visit admin_charity_needs_path(charity.slug)

    expect(page).to have_link("Deactivate")
    expect(Need.first.status_id).to eq(1)
    expect(page).to_not have_link("Suspend")

  end


  scenario "platform admin can deactivate and suspend need for charity through index page" do
    role = Role.find_by(name: 'Platform Admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    create_list(:status, 3)
    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_needs_path(charity.slug)

    within ".#{need1.name}" do
      expect(page).to have_link("Suspend")
      click_on "Deactivate"
    end

    expect(current_path).to eq(admin_charity_need_path(charity.slug, need1))

    visit admin_charity_needs_path(charity.slug)

    within ".#{need1.name}" do

      expect(page).to have_link("Activate")
      expect(Need.first.status_id).to eq(2)
      click_on("Suspend")
    end

    visit admin_charity_needs_path(charity.slug)

    within ".#{need1.name}" do
      expect(Need.first.status_id).to eq(3)
      expect(page).to_not have_link("Suspend")
      click_on("Activate")
    end

    expect(Need.first.status_id).to eq(1)

  end


  scenario "business admin can change status to activated and deactivated but not suspended through show" do

    role = Role.find_by(name: 'Business Admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    create_list(:status, 3)
    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_need_path(charity.slug, need1)

    expect(page).to_not have_link("Suspend")

    click_on "Deactivate"
    expect(Need.first.status_id).to eq(2)
    expect(page).to_not have_link("Suspend")

    click_on "Activate"
    expect(page).to have_link("Deactivate")
    expect(Need.first.status_id).to eq(1)


  end


  scenario "platform admin can deactivate and suspend need for charity through show page" do
    role = Role.find_by(name: 'Platform Admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    create_list(:status, 3)
    need1 = charity.needs.create(name: "Need-1", description: "description for Need-1", price: 10, needs_category: create(:needs_category))

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )


    visit admin_charity_need_path(charity.slug, need1)

    expect(page).to have_link("Suspend")
    click_on "Deactivate"
    expect(Need.first.status_id).to eq(2)
    click_on "Suspend"
    expect(Need.first.status_id).to eq(3)
    click_on "Activate"
    expect(Need.first.status_id).to eq(1)
    expect(page).to have_link("Suspend")
    expect(page).to have_link("Deactivate")

  end

end
