require 'rails_helper'

RSpec.describe CausesCharity, type: :model do
   it { should belong_to(:charity) }
   it { should belong_to(:cause) }
end
