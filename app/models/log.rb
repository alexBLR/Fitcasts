class Log < ActiveRecord::Base
	belongs_to :user

	validates :weight, presence:   true
	validates :goalweight, presence:   true
	validates :height, presence:   true
	validates :age, presence:   true

end
