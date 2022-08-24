set :environment, "development"

every 1.minute do
  rake 'user:story_deletion'
end

