class Weight < ActiveRecord::Base
	belongs_to :user

	validates :weight, presence:   true
	validates :goalweight, presence:   true
end
