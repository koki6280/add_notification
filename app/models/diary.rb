class Diary < ApplicationRecord
    acts_as_taggable
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	attachment :body_image, destroy: false

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
end
