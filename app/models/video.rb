class Video < ActiveRecord::Base
	has_many :favorite_videos
	has_many :users, :through => :favorite_videos

	has_many :workouts
	has_many :users, :through => :workouts
end
