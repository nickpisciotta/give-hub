require 'rails_helper'

RSpec.describe Charity, type: :model do
   it { should validate_presence_of(:name) }
   it { should validate_presence_of(:description) }
   it { should have_many(:causes_charities) }
   it { should have_many(:causes) }
   it { should have_many(:recipients) }
   it { should have_many(:needs) }
   it { should have_many(:user_roles) }
   it { should have_many(:users) }
   it { should belong_to(:status) }

   scenario "creating a slug method" do
     create_list(:status, 3)
     charity = create(:charity)

     expect(charity.slug).to eq("#{charity.name}".parameterize)
   end

   scenario "see if recipient belongs a charity" do
     create_list(:status, 3)
     recipient_one = create(:recipient)
     recipient_two = create(:recipient)
     charity_one = recipient_one.charity
     charity_two = recipient_two.charity

     expect(charity_one.associated_recipient?(recipient_one.id)).to eq(true)
     expect(charity_one.associated_recipient?(recipient_two.id)).to eq(false)
   end

   it "correctly identifies an active charity" do
     create_list(:status, 3)
     charity1 = create(:active_charity)
     charity2 = create(:inactive_charity)
     expect(charity1.active?).to eq(true)
     expect(charity2.active?).to eq(false)
   end

   it "correctly identifies an inactive charity" do
     create_list(:status, 3)
     charity1 = create(:active_charity)
     charity2 = create(:inactive_charity)
     expect(charity1.inactive?).to eq(false)
     expect(charity2.inactive?).to eq(true)
   end

   it "correctly identifies an suspended charity" do
     create_list(:status, 3)
     charity1 = create(:active_charity)
     charity2 = create(:suspended_charity)
     expect(charity1.suspended?).to eq(false)
     expect(charity2.suspended?).to eq(true)
   end

   it "correctly identifies all active charities" do
     create_list(:status, 3)
     create_list(:active_charity, 3)
     create_list(:inactive_charity, 5)
     create_list(:suspended_charity, 2)
     expect(Charity.all_active_charities.count).to eq(3)
   end

   it "correctly identifies all inactive charities" do
     create_list(:status, 3)
     create_list(:active_charity, 3)
     create_list(:inactive_charity, 5)
     create_list(:suspended_charity, 2)
     expect(Charity.all_inactive_charities.count).to eq(5)
   end

   it "correctly identifies all suspended charities" do
     create_list(:status, 3)
     create_list(:active_charity, 3)
     create_list(:inactive_charity, 5)
     create_list(:suspended_charity, 2)
     expect(Charity.all_suspended_charities.count).to eq(2)
   end

   it "correctly identifies all pending charities" do
     create_list(:status, 3)
     all_pendings = create_list(:inactive_charity, 5)
     create_list(:active_charity, 3)
     create_list(:suspended_charity, 3)
     Charity.create(name: "not pending inactive", description: "this one is not pending", created_at: 30.days.ago)
     expect(Charity.all_pending_charities.count).to eq(all_pendings.count)
   end

   it "correctly identifies if a recipient is associated with charity" do
     create_list(:status, 3)
     current_charity, other_charity = create_list(:charity, 2)
     associated = current_charity.recipients.create(name: "test", description: "test")
     unassociated = other_charity.recipients.create(name: "other test", description: "other test")

     expect(current_charity.associated_recipient?(unassociated.id)).to eq(false)

     expect(current_charity.associated_recipient?(associated.id)).to eq(true)
   end

   it "correctly identifies if all associated recipients charity" do
     create_list(:status, 3)
     current_charity, other_charity = create_list(:charity, 2)
     active1 = current_charity.recipients.create(name: "test1", description: "test1")
     active1.need_items.create(quantity: 1, need: create(:need), deadline: 5.days.from_now)

     active2 = current_charity.recipients.create(name: "test2", description: "test2")
     active2.need_items.create(quantity: 1, need: create(:need), deadline: 5.days.from_now)


     inactive1 = current_charity.recipients.create(name: "inactive1", description: "test")
     inactive1.need_items.create(quantity: 1, need: create(:need), deadline: 5.days.ago)
     inactive2 = current_charity.recipients.create(name: "inactive2", description: "test4")

     other_charity_active = other_charity.recipients.create(name: "other", description: "other")
     other_charity_active.need_items.create(quantity: 1, need: create(:need), deadline: 5.days.from_now)

     expect(current_charity.active_recipients.count).to eq(2)
     expect(current_charity.active_recipients.first.name).to eq("test1")
     expect(current_charity.active_recipients.last.name).to eq("test2")

   end

   it "creates correct form options for platform_admin" do
     create_list(:status, 3)
     create_list(:charity, 10)
     role = Role.find_by(name: 'Platform Admin')
     user = create(:user)
     user_role = UserRole.create(role_id: role.id, user_id: user.id)
     expect(Charity.form_options(user).count).to eq(10)
     expect(Charity.form_options(user).first).to eq([Charity.first.name, 1])
     expect(Charity.form_options(user).last).to eq([Charity.last.name, 10])
   end

   it "creates correct form options for business_admin" do
     create_list(:status, 3)
     user_charity1, user_charity2, other_charity = create_list(:charity, 3)
     role = Role.find_by(name: 'Business Admin')
     user = create(:user)
     user_role1 = UserRole.create(role_id: role.id, user_id: user.id, charity_id: user_charity1.id)
     user_role2 = UserRole.create(role_id: role.id, user_id: user.id, charity_id: user_charity2.id)

     expect(Charity.form_options(user).count).to eq(2)
     expect(Charity.form_options(user).first).to eq([user_charity1.name, 1])
     expect(Charity.form_options(user).last).to eq([user_charity2.name, 2])
   end

   it "creates a charity owner" do

     charity = create(:charity)
     reg = Role.find_by(name: 'Registered User')
     own = Role.find_by(name: 'Business Owner')
     user = create(:user)

     charity.create_charity_owner(user)
     expect(user.roles.first.name).to eq("Business Owner")
   end


end
