namespace :user do
  desc "User migration task"
  task :migrate => :environment do
    require "./db/usermigrate.rb"
  end
end