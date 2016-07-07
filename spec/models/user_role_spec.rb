require 'rails_helper'

RSpec.describe UserRole, type: :model do
  it { should belong_to(:role) }
  it { should belong_to(:charity) }
  it { should belong_to(:user) }

  it "should return a name" do
    role = Role.create(name: "role")
    ur = UserRole.create(user: create(:user), role: role, charity: create(:charity))
    expect(ur.name).to eq(role.name)
  end

end
