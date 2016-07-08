require 'rails_helper'

RSpec.describe Cart, type: :model do
  it "adds and deletes an item to and from the cart" do
    need_item1, need_item2 = create_list(:need_item, 2)
    cart = Cart.new({})
    cart.add_cart_item(need_item1.id, 1)

    expect(cart.contents).to eq({need_item1.id.to_s => 1})

    cart.add_cart_item(need_item2.id, 2)

    expect(cart.contents).to eq({need_item1.id.to_s => 1, need_item2.id.to_s => 2})

    cart.delete_cart_item(need_item2.id)

    expect(cart.contents).to eq({need_item1.id.to_s => 1})
  end

  it "it changes item quantity in the cart" do
    need_item1 = create(:need_item)

    cart = Cart.new({})
    cart.add_cart_item(need_item1.id, 3)

    expect(cart.contents).to eq({need_item1.id.to_s=>3})

    cart.change_cart_item_quantity(need_item1.id.to_s, 1)

    expect(cart.contents).to eq({need_item1.id.to_s=>1})

    cart.change_cart_item_quantity(need_item1.id.to_s, 6)

    expect(cart.contents).to eq({need_item1.id.to_s=>6})
  end

  it "it deletes item if quantity changed to 0 the cart" do
    need_item1 = create(:need_item)

    cart = Cart.new({})
    cart.add_cart_item(need_item1.id, 3)

    expect(cart.contents).to eq({need_item1.id.to_s=>3})

    cart.change_cart_item_quantity(need_item1.id.to_s, 0)

    expect(cart.contents).to eq({})
  end

  it "outputs accurate number for total items/price in cart" do
    need_item1, need_item2 = create_list(:need_item, 2)

    cart = Cart.new({})
    cart.add_cart_item(need_item1.id, 1)
    cart.add_cart_item(need_item2.id, 2)

    expect(cart.total_items).to eq(3)
    expect(cart.total_price).to eq(need_item1.price + need_item2.price * 2)
  end

  it "finds needs items" do
    need_item = create(:need_item)

    cart = Cart.new({})
    cart.add_cart_item(need_item.id, 2)

    expect(cart.get_need_items.first.need_item).to eq(need_item)
    expect(cart.get_need_items.first.quantity).to eq(2)
  end
end
