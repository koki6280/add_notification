class Diary < ApplicationRecord

	belongs_to :user
	attachment :body_image, destroy: false
end
