require 'rails_helper'

RSpec.describe FormPresenter, type: :model do

   it "creates correct charity form options for platform_admin" do
     create_list(:status, 3)
     create_list(:charity, 10)
     role = Role.find_by(name: 'Platform Admin')
     user = create(:user)
     user_role = UserRole.create(role_id: role.id, user_id: user.id)

     expect(FormPresenter.new(Charity.all).charity_form_options(user).count).to eq(10)
     expect(FormPresenter.new(Charity.all).charity_form_options(user).first).to eq([Charity.first.name, 1])
     expect(FormPresenter.new(Charity.all).charity_form_options(user).last).to eq([Charity.last.name, 10])

   end

   it "creates correct charity form options for business_admin" do
     create_list(:status, 3)
     user_charity1, user_charity2, other_charity = create_list(:charity, 3)
     role = Role.find_by(name: 'Business Admin')
     user = create(:user)
     user_role1 = UserRole.create(role_id: role.id, user_id: user.id, charity_id: user_charity1.id)
     user_role2 = UserRole.create(role_id: role.id, user_id: user.id, charity_id: user_charity2.id)

     expect(FormPresenter.new(Charity.all).charity_form_options(user).count).to eq(2)
     expect(FormPresenter.new(Charity.all).charity_form_options(user).first).to eq([user_charity1.name, 1])
     expect(FormPresenter.new(Charity.all).charity_form_options(user).last).to eq([user_charity2.name, 2])
   end
end
