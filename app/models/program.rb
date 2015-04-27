class Program < ActiveRecord::Base
	belongs_to :user
	has_many :workouts
	has_many :videos, through: :workouts

	validates :name, presence:   true

end
