require 'rails_helper'

RSpec.describe Recipient, type: :model do
   it { should validate_presence_of(:name) }
   it { should validate_presence_of(:description) }
   it { should have_many(:need_items) }
   it { should have_many(:donation_items) }
   it { should belong_to(:charity) }

   it "identifies active need items for recipient" do
     rec = create(:recipient)
     need_item = rec.need_items.create(quantity: 2, need: create(:need))

     expect(rec.active_need_items.first.name).to eq(need_item.name)

   end

   it "identifies active need items for recipient when some inactive" do
     rec = create(:recipient)
     active_need_item = rec.need_items.create(quantity: 2, need: create(:need))
     inactive_need_item = rec.need_items.create(quantity: 2, need: create(:need))
     donation = Donation.create(user: create(:user))
     DonationItem.create(quantity: 2, need_item_id: inactive_need_item.id, donation: donation)


     expect(rec.active_need_items.count).to eq(1)

   end

   it "identifies recipient need categories" do
     rec = create(:recipient)
     need_item1 = rec.need_items.create(quantity: 2, need: create(:need))

     expect(rec.need_categories.count).to eq(1)
     expect(rec.need_categories.first.name).to eq(need_item1.need.needs_category.name)

   end


end
