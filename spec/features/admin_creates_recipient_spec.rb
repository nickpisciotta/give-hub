require 'rails_helper'

RSpec.feature "admin can add recipient for charity" do
  scenario "business admin can add recipient" do
    role = Role.find_by(name: 'Business Admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    expect(charity.recipients.count).to eq(0)
    visit admin_charity_recipients_path(charity.slug)
    click_on "Add Recipient"

    expect(current_path).to eq(new_admin_charity_recipient_path(charity.slug))
    fill_in "Name", with: "Recipient-1"
    fill_in "Description", with: "description"
    click_on "Create Recipient"
    expect(current_path).to eq(admin_charity_recipient_path(charity.slug, Recipient.first))
    expect(page).to have_content("Recipient-1")
    expect(page).to have_content("description")
    expect(charity.recipients.count).to eq(1)
  end

  scenario "business owner can add a recipient" do

    role = Role.find_by(name: 'Business Owner')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_recipients_path(charity.slug)


    click_on "Add Recipient"

    expect(current_path).to eq(new_admin_charity_recipient_path(charity.slug))

    fill_in "Name", with: "Recipient"
    fill_in "Description", with: "Description for Recipient"
    click_on "Create Recipient"

    expect(current_path).to eq(admin_charity_recipient_path(charity.slug, charity.recipients.first))

    expect(page).to have_content("Recipient")
    expect(page).to have_content("Description for Recipient")
  end

  scenario "business owner cannot create recipient for other charity" do
    role = Role.find_by(name: 'Business Owner')
    user = create(:user)
    charity_one, charity_two = create_list(:charity, 2)

    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity_one.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit new_admin_charity_recipient_path(charity_two.slug)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("not authorized")
  end

  scenario "business admin cannot create recipient for other charity" do
    role = Role.find_by(name: 'Business Admin')
    user = create(:user)
    charity_one, charity_two = create_list(:charity, 2)

    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity_one.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit new_admin_charity_recipient_path(charity_two.slug)

    expect(current_path).to eq(root_path)
    expect(page).to have_content("not authorized")
  end

  scenario "platform admin can create recipient for charity" do

    role = Role.find_by(name: 'Platform Admin')
    user = create(:user)
    charity = create(:charity)

    user_role = UserRole.create(role_id: role.id, user_id: user.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_recipients_path(charity.slug)

    click_on "Add Recipient"

    expect(current_path).to eq(new_admin_charity_recipient_path(charity.slug))

    fill_in "Name", with: "Recipient"
    fill_in "Description", with: "Description for Recipient"
    click_on "Create Recipient"

    expect(current_path).to eq(admin_charity_recipient_path(charity.slug, charity.recipients.first))

    expect(page).to have_content("Recipient")
    expect(page).to have_content("Description for Recipient")
  end

  scenario "registered user cannot create recipient" do

    role = Role.find_by(name: 'Registered User')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity: charity)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit new_admin_charity_recipient_path(charity.slug)

    expect(page).to have_content("not authorized")
    expect(current_path).to eq(root_path)
  end

end
