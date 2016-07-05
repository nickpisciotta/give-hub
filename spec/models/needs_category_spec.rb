require 'rails_helper'

RSpec.describe NeedsCategory, type: :model do
   it { should validate_presence_of(:name) }
   it { should have_many(:needs) }
   it { should have_many(:need_items) }
   it { should have_many(:recipients) }

   scenario "creating a slug method" do
     needs_category = NeedsCategory.create(name: "Category 1")

     expect(needs_category.slug).to eq("category-1")
   end
end
