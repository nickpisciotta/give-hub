require 'rails_helper'

RSpec.feature "user can checkout with items in cart" do
  scenario "they checkout and see the donations page with their donation" do
    user = User.create(username: "test", password: "password", email: "test@example.com" )
    visit login_path
    fill_in "Username", with: "test"
    fill_in "Password", with: "password"
    click_on "Login to Account"

    need = create(:need)
    charity = create(:charity)
    recipient = Recipient.create(name: "worthy recipient", description: "all about the worthy recipient", charity_id: charity.id)
    need_item = NeedItem.create(quantity: 1, recipient_id: recipient.id,  need_id: need.id, created_at: Faker::Date.backward(10), updated_at: Faker::Date.backward(4), deadline: Faker::Date.forward(14))

    visit charity_recipient_path(recipient.charity.slug, recipient)
    click_on "add to cart"

    visit cart_index_path
    click_on "Checkout"
    click_on "Confirm Donation"

    expect(page).to have_content "Your donation, with ID 1, was received. Thank you!"
    expect(page).to have_content "#{need.name}"
    expect(page).to have_content "Total Donations: 1"
  end

  scenario "logged out user cannot checkout unless logged in" do
    need = create(:need)
    charity = create(:charity)
    recipient = Recipient.create(name: "worthy recipient", description: "all about the worthy recipient", charity_id: charity.id)
    need_item = NeedItem.create(quantity: 1, recipient_id: recipient.id,  need_id: need.id, created_at: Faker::Date.backward(10), updated_at: Faker::Date.backward(4), deadline: Faker::Date.forward(14))

    visit charity_recipient_path(recipient.charity.slug, recipient)
    click_on "add to cart"

    visit cart_index_path
    expect(page).to have_content "Login or Create Account to Checkout"
  end
end
