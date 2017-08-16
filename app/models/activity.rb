class Activity < ApplicationRecord
    belongs_to :image, optional: true
    belongs_to :user, optional: true
    
    has_many :calendar_dates
    has_many :bookings

    def serializable_hash options=nil
		attrs = {}
		attrs[:calendar] = calendar_dates
   		super.merge(attrs)
	end
end
