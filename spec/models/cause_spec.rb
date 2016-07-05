require 'rails_helper'

RSpec.describe Cause, type: :model do
  it { should have_many(:causes_charities) }
  it { should have_many(:charities) }
  it { should have_many(:recipients) }

  scenario "creating a slug method" do
    cause = Cause.create(name: "Test Name")
    expect(cause.slug).to eq("test-name")
  end

  scenario "finding active recipients" do
    create_list(:status, 3)
    recipient_one = create(:recipient)
    recipient_two = create(:recipient)
    old_item = create(:past_need_item)
    new_item = create(:future_need_item)
    cause = create(:cause)

    recipient_one.need_items << old_item
    recipient_one.charity.causes << cause

    recipient_two.need_items << new_item
    recipient_two.charity.causes << cause

    expect(cause.active_recipients.first).to eq(recipient_two)
  end
end
