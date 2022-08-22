
namespace :sample do
  desc 'saying hi to cron'
  task :test => [ :environment ] do
     puts 'hi cron :)'
     s = Story.delete_all
    #  where(['created_at <= ?', 2.minutes.ago]).each(&:destroy)
     puts s
  end
end
