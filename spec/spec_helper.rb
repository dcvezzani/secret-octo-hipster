require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/rails'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    # config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"

    # Controller specs won’t work out of the box if you’re using any of devise’s utility methods.
    # As of rspec-rails-2.0.0 and devise-1.1, the best way to put devise in your specs is simply to add the following into spec_helper:
    config.include Devise::TestHelpers, :type => :controller

    # include any custom matchers here
    # config.extend ControllerMacros, :type => :controller
    # config.include(MyRspecCustomMatcher)
    config.include ClientHelper, :type => :model

    # https://github.com/bmabey/database_cleaner
    # config.before(:suite) do
    #   DatabaseCleaner.strategy = :transaction
    #   DatabaseCleaner.clean_with(:truncation)
    # end

    # config.before(:each) do
    #   DatabaseCleaner.start
    # end

    # config.after(:each) do
    #   DatabaseCleaner.clean
    # end    
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  require 'factory_girl_rails'

  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean
  ActiveSupport::Dependencies.clear
  ActiveRecord::Base.instantiate_observers
  FactoryGirl.factories.clear
  FactoryGirl.reload

  Dir[Rails.root.join('app', 'helpers', '*.rb')].each do |file|
    require file
  end
end

=begin
Main documentation:
https://github.com/rspec/rspec-rails

A couple tutorials: 
http://jimmyzimmerman.com/blog/2007/11/simple-tutorials-for-learning-bdd-and-rspec.html
http://www.lukeredpath.co.uk/blog/developing-a-rails-model-using-bdd-and-rspec-part-1.html

Using FactoryGirl; where to place in spec_helper bootstrapped with spork:
http://stackoverflow.com/questions/6978082/factory-girl-associations-with-spork-discrepancy
http://railscasts.com/episodes/158-factories-not-fixtures?view=asciicast
https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
https://github.com/thoughtbot/factory_girl/tree/1.3.x

Using and configuring watchr:
http://www.rubyinside.com/how-to-rails-3-and-rspec-2-4336.html

Testing for redirection:
http://stackoverflow.com/questions/6139898/rspec-redirect-to-show-action
# e.g., response.should redirect_to(post_path(assigns[:post])

How To: Controllers and Views tests with Rails 3 (and rspec): 
https://github.com/plataformatec/devise/wiki/How-To%3a-Controllers-and-Views-tests-with-Rails-3-%28and-rspec%29

Using and configuring 'steak' gem:
http://www.ruby-on-rails-outsourcing.com/articles/2011/06/23/getting-started-with-steak/
http://jeffkreeftmeijer.com/2010/steak-because-cucumber-is-for-vegetarians/
https://github.com/cavalle/steak

What generators are available to rspec?
http://stackoverflow.com/questions/11062869/list-of-rspecs-generators

    controller
    helper
    install
    integration
    mailer
    model
    observer
    scaffold
    view

rails g helper ClientMessages

After adding devise, my tests started breaking.  What gives?
http://stackoverflow.com/questions/9508707/rail3-rspec-devise-rspec-controller-test-fails-unless-i-add-a-dummy-subject-cur

puts Faker::Name.singleton_methods(false)
name
first_name
last_name
prefix
suffix
title

puts Faker::Internet.singleton_methods(false)
email
free_email
safe_email
user_name
domain_name
fix_umlauts
domain_word
domain_suffix
ip_v4_address
ip_v6_address
url

puts Faker::Company.singleton_methods(false)
name
suffix
catch_phrase
bs

puts Faker::Address.singleton_methods(false)
city
street_name
street_address
secondary_address
building_number
zip_code
zip
postcode
street_suffix
city_suffix
city_prefix
state_abbr
state
country
latitude
longitude

puts Faker::Lorem.singleton_methods(false)
word
words
characters
sentence
sentences
paragraph
paragraphs
resolve

puts Faker::PhoneNumber.singleton_methods(false)
phone_number
cell_phone


Generating test data for development:
http://objectliteral.blogspot.com/2009/07/make-faker-work-with-factory-girl.html

=== controllers
%s/\[message\]/[@message]/g
%s/(message)/(@message)/g
%s/=> message./=> @message./g
%s/\n\s\+message = Message.create! valid_attributes\n/\r/g

  login_user

  before(:each) do
    @attachment = FactoryGirl.create(:attachment)
    #attachments = FactoryGirl.create_list(:attachment, 2)
  end

    FactoryGirl.attributes_for(:attachment).select{|k,v| !%w{id created_at updated_at}.include?(k)}

    {"warden.user.user.key" => session["warden.user.user.key"]}

=== views (acceptance)
    user = FactoryGirl.create(:user)
    messages = FactoryGirl.create_list(:message, 2)
    visit '/messages/index_by_categories'

    login_user

    #puts page.html

    page.should have_selector("table.client_messages>tr>th", :text => "Sender email".to_s, :count => 1)
    page.should have_selector("table.client_messages>tr>td", :text => "bob@mail.com".to_s, :count => 2)

=== models
  it { should have_many(:associate_profiles).dependent(:destroy) }

  it { should validate_presence_of(:territory) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:email) }

=== factories
  factory :client_message do
    ...
    type "ClientMessage"
  end

  factory :associate do
    name Faker::Name.name
    title "Contract Attorney"
    email Faker::Internet.email
    calendar Faker::Internet.url
    dropbox Faker::Internet.url
  end

=end


