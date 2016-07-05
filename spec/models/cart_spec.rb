require 'rails_helper'

# RSpec.describe Cart, type: :model do
#   it "adds//deletes an item to and from the cart" do
#     supply_item = Supply.create(name: "Twin Bedframe", value:  30.0, description: "New or used.  Used must be in good condition.", multiplier_type: "child")
#     supply_item1 = Supply.create(name: "Twin Mattress", value:  100.0, description: "Must be new.", multiplier_type: "child")
#
#     cart = Cart.new({})
#     cart.add_cart_item(supply_item.id, 1)
#
#     expect(cart.contents).to eq({"1" => 1})
#
#     cart.add_cart_item(supply_item1.id, 2)
#
#     expect(cart.contents).to eq({"1"=>1, "2"=>2})
#
#     cart.delete_cart_item(supply_item1.id)
#
#     expect(cart.contents).to eq({"1"=>1})
#   end
#
#   it "changes item quantity from the cart" do
#     supply_item1 = Supply.create(name: "Twin Mattress", value:  100.0, description: "Must be new.", multiplier_type: "child")
#
#     cart = Cart.new({})
#     cart.add_cart_item(supply_item1.id, 3)
#
#     expect(cart.contents).to eq({"1"=>3})
#
#     cart.change_cart_item_quantity("1", 1)
#
#     expect(cart.contents).to eq({"1"=>1})
#
#     cart.change_cart_item_quantity("1", 6)
#
#     expect(cart.contents).to eq({"1"=>6})
#   end
#
#   it "outputs accurate number for total items//price in cart" do
#     supply_item = Supply.create(name: "Twin Bedframe", value:  30.0, description: "New or used.  Used must be in good condition.", multiplier_type: "child")
#     supply_item1 = Supply.create(name: "Twin Mattress", value:  100.0, description: "Must be new.", multiplier_type: "child")
#     nationality1 = Nationality.create(photo_path: "somali_photo.jpeg",
#     info_link: "http://www.rescue.org/blog/a-precarious-life"\
#     "-somali-refugees-nairobi",
#     greeting: "somali_greeting.png", name: "Somali")
#     family1 = Family.create(first_name: "TestFirst", last_name: "TestLast",
#     arrival_date: 10.days.from_now, donation_deadline: 5.days.from_now,
#     nationality_id: nationality1.id, num_married_adults: 2,
#     num_unmarried_adults: 1, num_children_over_two: 1, num_children_under_two: 0,
#     description: "This married couple fled Somalia in 2001 with their sone and"\
#     " the wife's elderly mother.  They have lived in Dadaab refugee camp for"\
#     " the past 15 years.")
#
#     family1.create_supply_items
#
#     cart = Cart.new({})
#     cart.add_cart_item(supply_item.id, 1)
#     cart.add_cart_item(supply_item1.id, 2)
#
#     expect(cart.total_items).to eq(3)
#     expect(cart.total_price).to eq(230.0)
#   end
#
#   it "finds supply items" do
#     nationality1 = Nationality.create(photo_path: "x",
#     info_link: "x",
#     greeting: "x", name: "Somali")
#     family1 = Family.create(first_name: "TestFirst", last_name: "TestLast",
#     arrival_date: 10.days.from_now, donation_deadline: 5.days.from_now,
#     nationality_id: nationality1.id, num_married_adults: 2,
#     num_unmarried_adults: 1, num_children_over_two: 1, num_children_under_two: 0,
#     description: "x")
#     supply = Supply.create(name: "Twin Mattress", value:  100.0, description: "Must be new.", multiplier_type: "child")
#     supply_item = supply.supply_items.create(family: family1, quantity: 4)
#
#     cart = Cart.new({})
#     cart.add_cart_item(supply_item.id, 2)
#
#     expect(cart.get_supply_items.first.supply_item).to eq(supply_item)
#     expect(cart.get_supply_items.first.quantity).to eq(2)
#   end
# end
