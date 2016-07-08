require 'rails_helper'

RSpec.describe Need, type: :model do
   it { should validate_presence_of(:name) }
   it { should validate_presence_of(:description) }
   it { should validate_presence_of(:price) }
   it { should have_many(:need_items) }
   it { should have_many(:recipients) }
   it { should have_many(:donation_items) }
   it { should belong_to(:needs_category) }
   it { should belong_to(:charity) }
   it { should belong_to(:status) }

   it "correctly identifies an active need" do
     active = create(:active_need)
     inactive = create(:inactive_need)
     suspended = create(:suspended_need)
     expect(active.active?).to eq(true)
     expect(inactive.active?).to eq(false)
     expect(suspended.active?).to eq(false)
   end

   it "correctly identifies an inactive need" do
     active = create(:active_need)
     inactive = create(:inactive_need)
     suspended = create(:suspended_need)
     expect(active.inactive?).to eq(false)
     expect(inactive.inactive?).to eq(true)
     expect(suspended.inactive?).to eq(false)
   end

   it "correctly identifies an active need" do
     active = create(:active_need)
     inactive = create(:inactive_need)
     suspended = create(:suspended_need)
     expect(active.suspended?).to eq(false)
     expect(inactive.suspended?).to eq(false)
     expect(suspended.suspended?).to eq(true)
   end

   it "correctly identifies all active inactive and suspended needs" do
     active = create(:active_need)
     inactive = create(:inactive_need)
     suspended = create(:suspended_need)
     expect(Need.suspended.count).to eq(1)
     expect(Need.inactive.count).to eq(1)
     expect(Need.active.count).to eq(1)
   end
end
