# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :environment, "development"
set :output, "/home/dev/Documents/Instagram-TestProject/instagram-clone/log/cron_log.log"

every 1.minute do
  rake 'sample:test'
end

# Learn more: http://github.com/javan/whenever
