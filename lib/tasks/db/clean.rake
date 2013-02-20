# tasks/db/clean.rake

namespace :db do

  namespace :truncate do
    desc "Truncate all existing data"
    task :all => "db:load_config" do
      ActiveRecord::Base.establish_connection
      DatabaseCleaner.clean_with :truncation
    end
  end

  desc "Truncate all existing data except users table; db:truncate:all to truncate everything"
  task :truncate => "db:load_config" do
    ActiveRecord::Base.establish_connection
    # DatabaseCleaner.strategy = :truncation, {:except => %w[widgets]}
    # DatabaseCleaner.clean


    preserved_tables = %w[users templates questions question_categories simple_values] 
    target_tables = ENV["TABLES"].split(/\s+/) if ENV["TABLES"]

    if target_tables.nil?
      DatabaseCleaner.clean_with :truncation, {:except => preserved_tables}
      puts ">>> #{preserved_tables.join(", ")} tables were not removed; use rake db:truncate:all to remove everything
      "
    else
      DatabaseCleaner.clean_with :truncation, {:only => target_tables}
      puts ">>> only #{target_tables.join(", ")} tables were removed; use rake db:truncate:all to remove everything
      or leave out TABLES environment variable to remove all but 
      the default preserved tables: #{preserved_tables} 
      "
    end
  end
end
