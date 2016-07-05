require 'rails_helper'

RSpec.describe Need, type: :model do
   it { should validate_presence_of(:name) }
   it { should validate_presence_of(:description) }
   it { should validate_presence_of(:price) }
   it { should have_many(:need_items) }
   it { should have_many(:recipients) }
   it { should have_many(:donation_items) }
   it { should belong_to(:needs_category) }
   xit { should validate_uniqueness_of(:name) }
end
