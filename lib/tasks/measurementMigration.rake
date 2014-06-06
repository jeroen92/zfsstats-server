namespace :measurement do
  desc "Measurement migration task"
  task :migrate => :environment do
    require "./db/migrateMeasurementData.rb"
  end
end