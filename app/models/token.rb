class Token < ApplicationRecord
    validates :token, presence: true

	belongs_to :user, required: true
end
