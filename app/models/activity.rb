class Activity < ApplicationRecord
    validates :num_of_bookings, presence: true
    validates :detailed_address, presence: true

    belongs_to :image, optional: true
    belongs_to :user, optional: true
    
    has_many :calendar_dates
    has_many :bookings

    has_many :rates, dependent: :destroy

    geocoded_by :detailed_address, latitude: :lat, longitude: :lng 
    reverse_geocoded_by :lat, :lng, address: :detailed_address
    after_validation :geocode

    def isk_fully_booked?

    end

    def serializable_hash options=nil
      attrs = {}
      attrs[:calendar] = calendar_dates

      cnt = rates.count
      sum = 0
		  rates.each{|r| sum += r.rate} if cnt > 0
		  attrs[:rate] = sum / (cnt == 0 ? 1 : cnt)

   		super.merge(attrs)
	  end
end
