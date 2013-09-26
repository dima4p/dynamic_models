# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    I18n.locale = :en
    DatabaseCleaner.start
    begin
      Proxy.connection.create_table 'examples'
      Proxy.connection.add_column 'examples', :name, :string
      Proxy.connection.add_column 'examples', :position, :integer
      Proxy.connection.add_column 'examples', :created_at, :datetime
      Proxy.connection.add_column 'examples', :updated_at, :datetime
    rescue
      nil
    end
  end

  config.after(:each) do
    DatabaseCleaner.clean rescue nil
    Proxy.connection.drop_table 'examples' rescue nil
    Proxy.reset_table_name
  end

  config.after(:suite) do
    Proxy.connection.tables.each do |table|
      Proxy.connection.drop_table table
    end
  end

  config.include Capybara::DSL
  Capybara.default_wait_time = 1
  Capybara.javascript_driver = :webkit
end

I18n.locale = :en

def logger
  Rails.logger
end

def choose_autocomplete_result(item_text, input_selector="input[data-autocomplete]")
  page.execute_script %Q{ $('#{input_selector}').trigger("focus") }
  page.execute_script %Q{ $('#{input_selector}').trigger("keydown") }
  # Set up a selector, wait for it to appear on the page, then use it.
  item_selector = "ul.ui-autocomplete li.ui-menu-item a:contains('#{item_text}')"
  page.should have_selector item_selector
  page.execute_script %Q{ $("#{item_selector}").trigger("mouseenter").trigger("click"); }
end
