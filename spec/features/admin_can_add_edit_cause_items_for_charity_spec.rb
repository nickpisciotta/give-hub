require 'rails_helper'

RSpec.feature "admin can add cause items for charity" do
  scenario "admin adds cause items" do
    role = Role.find_by(name: "Business Admin")
    user = create(:user)
    charity = create(:charity)
    cause1, cause2, cause3 = create_list(:cause, 3)

    user_role = UserRole.create(role_id: role.id,
                                user_id: user.id,
                                charity_id: charity.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_dashboard_path(charity.slug)

    within(".causes") do
      expect(page).to_not have_content(cause2.name)
    end

    click_on "Add Cause"

    expect(current_path).to eq(new_admin_charity_causes_charity_path(charity.slug))

    expect(page).to have_content(charity.name)

    select "#{cause2.name}", from: "causes_charity[cause_id]"

    click_on "Add Cause"

    expect(current_path).to eq(admin_charity_dashboard_path(charity.slug))

    within(".causes") do
      expect(page).to have_content(cause2.name)
    end

  end

end
