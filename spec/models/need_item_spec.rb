require 'rails_helper'

RSpec.describe NeedItem, type: :model do
   it { should belong_to(:need) }
   it { should belong_to(:recipient) }
   it { should have_many(:donation_items) }

   it "name returns need name" do
     create_list(:status, 3)
     need_item = create(:future_need_item)

     expect(need_item.name).to eq(need_item.need.name)
   end

   it "description returns need description" do
     create_list(:status, 3)
     need_item = create(:future_need_item)

     expect(need_item.description).to eq(need_item.need.description)
   end

   it "price returns need price" do
     create_list(:status, 3)
     need_item = create(:future_need_item)

     expect(need_item.price).to eq(need_item.need.price)
   end

   it "charity returns recipient's charity" do
     create_list(:status, 3)
     need_item = create(:future_need_item)

     expect(need_item.charity).to eq(need_item.recipient.charity)
   end

   it "quantity_remaning returns recipient's remaining need quantity" do
     create_list(:status, 3)
     need_item = NeedItem.create(quantity: 10, need: create(:need))
     donation_item1 = DonationItem.create(quantity: 1, need_item_id: need_item.id)
     donation_item1 = DonationItem.create(quantity: 6, need_item_id: need_item.id)

     expect(need_item.quantity_remaining).to eq(3)
   end

   it "subtotal returns subtotal of need_item" do
      create_list(:status, 3)
       need_item = create(:future_need_item)

       expect(need_item.subtotal(2).to_int).to eq(2.0 * need_item.price)
   end

end
