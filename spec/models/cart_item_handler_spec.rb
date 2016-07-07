require 'rails_helper'

RSpec.describe CartItemHandler, type: :model do
  it "initializes correctly" do
    need_item = create(:need_item)
    handler = CartItemHandler.new(need_item.id, 1)

    expect(handler.need_item.name).to eq(need_item.name)
    expect(handler.quantity).to eq(1)
  end

  it "has access to need item methods" do
    need_item = create(:need_item)
    handler = CartItemHandler.new(need_item.id, 1)

    expect(handler.charity).to eq(need_item.charity)

  end

end
