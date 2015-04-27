desc "Remove old searches"
task :remove_old_searches => :environment do
Search.delete_all ["created_at < ?", 2.week.ago]
end