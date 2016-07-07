require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:email) }
  it { should have_secure_password }
  it { should have_many(:donations) }
  it { should have_many(:donation_items) }
  it { should have_many(:user_roles) }
  it { should have_many(:charities) }

  it "identifies a platform admin" do
    role = Role.find_by(name: 'Platform Admin')
    user = create(:user)
    user_role = UserRole.create(role_id: role.id, user_id: user.id)
    expect(user.platform_admin?).to eq(true)
    expect(user.current_admin?).to eq(true)
    expect(user.business_owner?).to eq(false)
    expect(user.business_admin?).to eq(false)
    expect(user.delete_permission?).to eq(true)
  end

  it "identifies a business admin" do
    role = Role.find_by(name: 'Business Admin')
    user = create(:user)
    user_role = UserRole.create(role_id: role.id, user_id: user.id)
    expect(user.platform_admin?).to eq(false)
    expect(user.current_admin?).to eq(true)
    expect(user.business_owner?).to eq(false)
    expect(user.business_admin?).to eq(true)
    expect(user.delete_permission?).to eq(false)
  end

  it "identifies a business owner" do
    role = Role.find_by(name: 'Business Owner')
    user = create(:user)
    user_role = UserRole.create(role_id: role.id, user_id: user.id)
    expect(user.platform_admin?).to eq(false)
    expect(user.current_admin?).to eq(true)
    expect(user.business_owner?).to eq(true)
    expect(user.business_admin?).to eq(false)
    expect(user.delete_permission?).to eq(true)
  end


end
