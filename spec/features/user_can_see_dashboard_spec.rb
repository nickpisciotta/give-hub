require 'rails_helper'

RSpec.feature "user sees dashboard" do
  scenario "dashboard not shown until authenticated user" do

    user = User.create(username: "Robbie", password: "password", email: "test@example.com")

    visit dashboard_path(user)

    expect(current_path).to eq(login_path)

    fill_in "Username", with: "Robbie"
    fill_in "Password", with: "password"
    click_on "Login to Account"

    expect(current_path).to eq(dashboard_path)
  end
end
