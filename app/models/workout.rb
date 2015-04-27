class Workout < ActiveRecord::Base
	belongs_to :video
    belongs_to :user
    belongs_to :program
end
