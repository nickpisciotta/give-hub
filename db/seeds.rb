class Seed

  def initialize
    create_statuses
    create_causes
    create_charities
    create_need_categories
    create_users
    create_needs
    create_recipients
    create_donations
    create_need_items
    create_donation_items
    create_roles
    create_admins
  end

  def create_charities
    20.times do
      charity = Charity.create!(
      name: Faker::Company.name,
      tagline: Faker::Company.catch_phrase,
      description: Faker::Hipster.sentences(1),
      status_id: 1)
      rand(1..3).times do
        cause = Cause.find(rand(1..10))
        if !charity.causes.include?(cause)
          charity.causes << cause
        end
      end
    end
  end

  def create_recipients
    100.times do
      charity = Charity.find(Random.rand(1..20))
      Recipient.create!(
      name: Faker::Name.name,
      description: Faker::Name.title,
      charity_id: charity.id)
    end
  end

  def create_users
    user = User.create!(username: "jmejia@turing.io", password: "password", email: "jmejia@turing.io")
    99.times do
      User.create!(
      username: Faker::Internet.user_name,
      password: Faker::Internet.password,
      email: Faker::Internet.email
      )
    end
  end

  def create_donations
    100.times do
      user = User.find(Random.new.rand(1..100))
      donation = Donation.create!(user_id: user.id)
    end
  end

  def create_donation_items
    500.times do
      donation = Donation.find(Random.new.rand(1..100))
      need_item = NeedItem.find(Random.rand(1..100))
      DonationItem.create!(donation_id: donation.id, quantity: rand(1..10), need_item_id: need_item.id)
    end
  end

  def create_need_items
    200.times do
      need = Need.find(Random.new.rand(1..500))
      recipient = Recipient.find(Random.new.rand(1..100))
      NeedItem.create!(deadline: Faker::Date.forward(25), quantity: rand(10..100), recipient_id: recipient.id,
      need_id: need.id)
    end
  end

  def create_causes
    Cause.create!(name: "Environment",
                  tagline: Faker::Company.catch_phrase,
                  description: Faker::Hipster.sentences(1))
    Cause.create!(name: "Poverty",
                  tagline: Faker::Company.catch_phrase,
                  description: Faker::Hipster.sentences(1))
    Cause.create!(name: "Humanitarian",
                  tagline: Faker::Company.catch_phrase,
                  description: Faker::Hipster.sentences(1))
    Cause.create!(name: "Youth",
                  tagline: Faker::Company.catch_phrase,
                  description: Faker::Hipster.sentences(1))
    Cause.create!(name: "Education",
                  tagline: Faker::Company.catch_phrase,
                  description: Faker::Hipster.sentences(1))
    Cause.create!(name: "Economic Development",
                  tagline: Faker::Company.catch_phrase,
                  description: Faker::Hipster.sentences(1))
    Cause.create!(name: "LGBTI",
                  tagline: Faker::Company.catch_phrase,
                  description: Faker::Hipster.sentences(1))
    Cause.create!(name: "Immigration",
                  tagline: Faker::Company.catch_phrase,
                  description: Faker::Hipster.sentences(1))
    Cause.create!(name: "Animal Rights",
                  tagline: Faker::Company.catch_phrase,
                  description: Faker::Hipster.sentences(1))
    Cause.create!(name: "Civil Rights",
                  tagline: Faker::Company.catch_phrase,
                  description: Faker::Hipster.sentences(1))
  end

  def create_need_categories
    10.times do
      NeedsCategory.create(
      name: Faker::Commerce.department,
      tagline:Faker::Company.catch_phrase,
      description:Faker::Hipster.sentences(1)
      )
    end
  end

  def create_needs
    500.times do
      needs_category = NeedsCategory.find(Random.new.rand(1..10))
      Need.create!(
      name: Faker::Commerce.product_name,
      description: Faker::Commerce.color,
      price: Faker::Commerce.price,
      needs_category_id: needs_category.id,
      date: Faker::Date.forward(25),
      charity_id: rand(1..20)
      )
    end
  end

  def create_roles
    Role.create!(name: "Registered User")
    Role.create!(name: "Platform Admin")
    Role.create!(name: "Business Owner")
    Role.create!(name: "Business Admin")
  end

  def create_statuses
    Status.create(name: "Active")
    Status.create(name: "Inactive")
    Status.create(name: "Suspended")
  end

  def create_admins
    business_admin = User.create(username: "business_admin", email: "user@user.com", password: "password")
    business_admin.user_roles.create(role: Role.find_by(name: "Business Admin"),
                                                        charity_id: 1)
    business_owner = User.create(username: "business_owner", email: "user@user.com", password: "password")
    business_owner.user_roles.create(role: Role.find_by(name: "Business Owner"),
                                                        charity_id: 1)
    platform_admin = User.create(username: "platform_admin", email: "user@user.com", password: "password")
    platform_admin.user_roles.create(role: Role.find_by(name: "Platform Admin"),
                                                        charity_id: 1)
  end


end



Seed.new
