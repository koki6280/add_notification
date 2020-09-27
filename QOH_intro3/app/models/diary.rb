class Diary < ApplicationRecord
    acts_as_taggable
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	attachment :body_image, destroy: false
	validates :body, presence: true, length: { maximum: 200 }
	validates :exercise, presence: true
	validates :sleep, presence: true
	validates :cigarette, presence: true
	validates :drinking, presence: true

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end
end
