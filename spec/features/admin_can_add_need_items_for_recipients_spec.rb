require 'rails_helper'

RSpec.feature "admin can add need items for recipients" do
  scenario "need items added to recipient" do
    role = Role.find_by(name: "Business Admin")
    user = create(:user)
    charity = create(:charity)
    status = create(:status)
    user_role = UserRole.create(role_id: role.id,
                                user_id: user.id,
                                charity_id: charity.id)
    need = charity.needs.create(name: "Need-1",
                                description: "description for Need-1",
                                price: 10,
                                needs_category: create(:needs_category))
    recipient = Recipient.create(name: "Recipient",
                                 description: "Recipient description",
                                charity_id: charity.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_recipients_path(charity.slug)

    within ".#{recipient.name}" do
      click_on "View Details"
    end

    expect(current_path).to eq(admin_charity_recipient_path(charity.slug, recipient))

    expect(page).to have_content(recipient.name)


    expect(page).to have_content("Recipient Needs")
    expect(page).to have_content("Quantity")
    expect(page).to have_content("Deadline")

    click_on "Add Need for this Recipient"

    expect(current_path).to eq(new_admin_charity_recipient_need_item_path(charity.slug, recipient))

    select "#{need.name}", from: "need_item[need_id]"
    select 5, from: "need_item[quantity]"
    fill_in 'need_item[deadline]', with: '2016/07/20'

    click_on "Add Need"

    expect(current_path).to eq(admin_charity_recipient_path(charity.slug, recipient))

    within(".#{need.name}") do
      expect(page).to have_content(need.name)
    end

    need_item_quantity = recipient.need_items.find_by(need_id: need.id).quantity

    within(".quantity-#{need_item_quantity}") do
      expect(page).to have_content(need_item_quantity)
    end

    need_item_deadline = recipient.need_items.find_by(need_id: need.id).deadline

    expect(page).to have_content(format_date(need_item_deadline))
  end
end
