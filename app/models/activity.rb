class Activity < ApplicationRecord
    belongs_to :image, optional: true
    belongs_to :user, optional: true
    
    has_many :calendar_dates
    has_many :bookings

    has_many :rates, dependent: :destroy

    validates :num_of_bookings, presence: true

    def serializable_hash options=nil
		attrs = {}
		attrs[:calendar] = calendar_dates
   		super.merge(attrs)
	end
end
