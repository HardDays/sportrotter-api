class Booking < ApplicationRecord
    validates :date, presence: true
    belongs_to :user
    belongs_to :activity

end
