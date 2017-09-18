class Rate < ApplicationRecord
    validates :rate, presence: true, inclusion: 1..5

	belongs_to :user
	belongs_to :activity
end
