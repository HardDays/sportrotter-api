class Token < ApplicationRecord
    validates :token, presence: true

	belongs_to :user, required: true

    def is_valid?()
		#fix here
		hours = (Time.now.utc - updated_at) / 1.hour
		return true
	end
end
