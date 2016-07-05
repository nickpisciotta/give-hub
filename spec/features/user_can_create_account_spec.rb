require 'rails_helper'

RSpec.feature "user can create an account" do
  scenario "they become logged in and see dashboard page" do
    role = Role.find_by(name: "Registered User")
    visit login_path
    click_on "Create Account"

    fill_in "Username", with: "Robbie"
    fill_in "Password", with: "password"
    fill_in "Email", with: "email@example.com"
    click_on "Create Account"

    expect(page).to have_content "Welcome, Robbie"
    expect(page).to have_content "Dashboard"
    expect(User.first.roles.first.name).to eq("Registered User")
    expect(User.first.roles.count).to eq(1)
    expect(page).to have_content "Logout"
    expect(page).to_not have_content "Login"
  end

  scenario "they enter no email and get error" do
    visit login_path
    click_on "Create Account"

    fill_in "Username", with: "Robbie"
    fill_in "Password", with: "password"
    fill_in "Email", with: ""
    click_on "Create Account"

    expect(page).to have_content "Email can't be blank"
  end
end
