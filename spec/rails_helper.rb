# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

def format_date(date)
  date.to_formatted_s(:long)
end
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end

shared_context "standard test dataset" do
  category1 = Category.create(name: "Most Critical", slug: "most-critical")
  category2 = Category.create(name: "Elderly", slug: "elderly")
  category3 = Category.create(name: "Children", slug: "children")
  category4 = Category.create(name: "Single Mother", slug: "single-mother")
  category5 = Category.create(name: "Middle East", slug: "middle-east")
  category6 = Category.create(name: "East Asia", slug: "east-asia")
  category7 = Category.create(name: "Africa", slug: "africa")
  category8 = Category.create(name: "Latin America", slug: "latin-america")

  nationality1 = Nationality.create(photo_path: "http://www.criticalthreats.org/sites/default/files/AEI_Somalia_Map_Political.gif" ,info_link: "Somali", greeting: "most-critical", name: "Somali")
  nationality2 = Nationality.create(photo_path: "http://www.edmaps.com/Syrian_Civil_War_Territorial_Control_Map_November_28.png" ,info_link: "Syrian", greeting: "elderly", name: "Syrian")
  nationality3 = Nationality.create(photo_path: "http://2.bp.blogspot.com/-h9mc-KDynlU/UtL5BM3CkvI/AAAAAAAABso/a8MB0YFhehU/s1600/iraq_control_qaeda_kurdistan_2014-01-12.png" ,info_link: "Iraqi", greeting: "children", name: "Iraqi")
  nationality4 = Nationality.create(photo_path: "http://asia.nikkei.com/var/site_cache/storage/images/node_43/node_51/2015/201501/20150128/20150128-myanmar-map/2281975-1-eng-GB/20150128-Myanmar-map_article_main_image.png" ,info_link: "Burmese", greeting: "single-mother",  name: "Burmese")
  nationality5 = Nationality.create(photo_path: "http://www.bizbilla.com/country-maps/maps/bhutan-admin.jpg" ,info_link: "Bhutanese", greeting: "east-asia", name: "Bhutanese")

  family1 = Family.create(first_name: "TestFirst", last_name: "TestLast", arrival_date: 10.days.from_now, donation_deadline: 5.days.from_now, nationality_id: nationality1.id, num_married_adults: 2, num_unmarried_adults: 1, num_children_over_two: 0, num_children_under_two: 0)
  family2 = Family.create(first_name: "TestFirst", last_name: "TestLast", arrival_date: 10.days.from_now, donation_deadline: 5.days.from_now, nationality_id: nationality2.id, num_married_adults: 2, num_unmarried_adults: 1, num_children_over_two: 2, num_children_under_two: 1)
  family3 = Family.create(first_name: "TestFirst", last_name: "TestLast", arrival_date: 10.days.from_now, donation_deadline: 5.days.from_now, nationality_id: nationality3.id, num_married_adults: 2, num_unmarried_adults: 1, num_children_over_two: 0, num_children_under_two: 0)
  family4 = Family.create(first_name: "TestFirst", last_name: "TestLast", arrival_date: 10.days.from_now, donation_deadline: 5.days.from_now, nationality_id: nationality4.id, num_married_adults: 2, num_unmarried_adults: 1, num_children_over_two: 0, num_children_under_two: 0)
  family5 = Family.create(first_name: "TestFirst", last_name: "TestLast", arrival_date: 10.days.from_now, donation_deadline: 5.days.from_now, nationality_id: nationality5.id, num_married_adults: 2, num_unmarried_adults: 1, num_children_over_two: 0, num_children_under_two: 0)

  family1.categories << [category1, category2]
  family2.categories << [category3]
  family3.categories << [category4]
  family4.categories << [category5]
  family5.categories << [category2, category6]

  Supply.create(name: "Twin Bedframe", value:  30.0, description: "New or used.  Used must be in good condition.", multiplier_type: "child"  )
  Supply.create(name: "Twin Mattress", value:  100.0, description: "Must be new.", multiplier_type: "child" )

  Supply.create(name: "Full Bedframe", value: 50.0, description: "New or used.  Used must be in good condition.", multiplier_type: "adult" )
  Supply.create(name: "Full Mattress", value: 150.0, description: "Must be new.", multiplier_type: "adult" )
  Supply.create(name: "Dresser", value: 50.0, description: "New or used.  Used must be in good condition.", multiplier_type: "adult")

  Supply.create(name: "Couch", value: 100.0, description: "New or used.  Used must be in good condition.", multiplier_type: "household")
  Supply.create(name: "Kitchen Table", value: 40.0, description: "New or used.  Used must be in good condition.", multiplier_type: "household")
  Supply.create(name: "Large Pot", value: 3.0, description: "New or used.", multiplier_type: "household")
  Supply.create(name: "Small Pot", value: 3.0, description: "New or used.", multiplier_type: "household")


  Supply.create(name: "Kitchen Chair", value: 10.0, description: "New or used.  Used must be in good condition.", multiplier_type: "person")
  Supply.create(name: "Silverware Set", value: 1.5, description: "New or used. Set consists of fork, spoon and knife.", multiplier_type: "person")
  Supply.create(name: "Plate", value: 2.0, description: "New or used.", multiplier_type: "person")

  Supply.create(name: "Crib", value: 50.0, description:"New or used.  Used must be in good condition.", multiplier_type: "baby")
  Supply.create(name: "Car Seat", value: 150.0, description: "Must be new.", multiplier_type: "baby")
  Supply.create(name: "Stroller", value: 50.0, description: "New or used.  Used must be in good condition.", multiplier_type: "baby")
  Supply.create(name: "Diapers", value: 15.0, description: "Must be new.", multiplier_type: "baby")

  Supply.create(name: "Backpack", value: 7.50, description:"For school-aged child.  New or used.  Used must be in good condition.", multiplier_type: "child")
  Supply.create(name: "School Supplies", value: 10.0, description: "3 notebooks, set of pens, set of pencils. Must be new.", multiplier_type: "child")

  family1.create_supply_items
  family2.create_supply_items
  family3.create_supply_items
  family4.create_supply_items
  family5.create_supply_items

  user1 = User.create(username: "user1", password: "password")
  user2 = User.create(username: "user2", password: "password")

  donation1 = Donation.create(status: 'pledged', user: user1)
  donation2 = Donation.create(status: 'pledged', user: user1)
  donation3 = Donation.create(status: 'pledged', user: user2)

  donation_item1 = DonationItem.create(quantity: 1, supply_item: family1.supply_items.first, donation: donation1)

  donation_item2 = DonationItem.create(quantity: 1, supply_item: family2.supply_items.last, donation: donation1)

  donation_item3 = DonationItem.create(quantity: 1, supply_item: family3.supply_items.first, donation: donation2)

  donation_item4 = DonationItem.create(quantity: 1, supply_item: family4.supply_items.first, donation: donation3)
end
