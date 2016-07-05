require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:email) }
  xit { should validate_uniqueness_of(:username) }
  xit { should validate_uniqueness_of(:email) }
  it { should have_secure_password }
end
