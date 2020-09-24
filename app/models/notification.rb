class Notification < ApplicationRecord
	default_scope->{order(created_ad: :desc)}

	belongs_to :diary, optional: true
	belongs_to :comment, optional: true
	belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id', optional: true
	belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
