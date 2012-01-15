desc "This task is called by the Heroku scheduler add-on"
task :reset_data => :environment do
  puts "Deleting Budget entries..."
  Budget.destroy_all
  puts "Deleting Goal entries..."
  Goal.destroy_all
  puts "done."
end

task :clean_submits => :environment do
  puts "Deleting Submit entries..."
  Submit.destroy_all
  puts "done."
end
