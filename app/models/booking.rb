class Booking < ApplicationRecord
    validates :date, presence: true
    validates :num_of_participants, presence: true
    belongs_to :user
    belongs_to :activity

end
