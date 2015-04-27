class Cal < ActiveRecord::Base
	belongs_to :user
	validates :calburnt, presence:   true
	
end
