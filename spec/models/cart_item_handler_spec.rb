require 'rails_helper'

# RSpec.describe CartItemHandler, type: :model do
#   it "initializes correctly" do
#     nationality = Nationality.create(photo_path: "x",
#       info_link: "x",
#       greeting: "x",
#       name: "Somali")
#
#     fam1 = Family.create(first_name: "x",
#       last_name: "x",
#       arrival_date: 10.days.from_now,
#       donation_deadline: 5.days.from_now,
#       nationality: nationality,
#       num_married_adults: 2,
#       num_unmarried_adults: 1,
#       num_children_over_two: 1,
#       num_children_under_two: 0)
#     supply = Supply.create(name: "Twin Bedframe",
#       value:  30.0,
#       description: "Sample.",
#       multiplier_type: "child")
#     supply_item = SupplyItem.create(family: fam1, supply: supply, quantity: 2)
#
#     handler = CartItemHandler.new(supply_item.id, 1)
#
#     expect(handler.supply_item.name).to eq("Twin Bedframe")
#     expect(handler.quantity).to eq(1)
#   end
# end
