require 'rails_helper'

RSpec.feature "admin can delete recipient from charity" do
  scenario "business admin can delete recipient" do

    role = Role.create(name: 'business_admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    recipient = Recipient.create(name: "Hawaii", description: "Hawaiian description", charity_id: charity.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_recipients_path(charity.slug)

    within ".#{recipient.name}" do
      click_on "Delete"
    end
    expect(current_path).to eq(admin_charity_recipients_path(charity.slug))
    expect(page).to_not have_content(recipient.name)
    expect(page).to_not have_content(recipient.description)
  end

  scenario "business owner can delete recipient" do
    role = Role.create(name: 'business_owner')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    recipient = Recipient.create(name: "Hawaii", description: "Hawaiian description", charity_id: charity.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_recipients_path(charity.slug)

    within ".#{recipient.name}" do
      click_on "Delete"
    end
    expect(current_path).to eq(admin_charity_recipients_path(charity.slug))
    expect(page).to_not have_content(recipient.name)
    expect(page).to_not have_content(recipient.description)
  end

  scenario "platform admin can delete recipient" do
    role = Role.create(name: 'platform_admin')
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    recipient = Recipient.create(name: "Hawaii", description: "Hawaiian description", charity_id: charity.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_recipients_path(charity.slug)

    within ".#{recipient.name}" do
      click_on "Delete"
    end
    expect(current_path).to eq(admin_charity_recipients_path(charity.slug))
    expect(page).to_not have_content(recipient.name)
    expect(page).to_not have_content(recipient.description)
  end
end
