class Activity < ApplicationRecord
    belongs_to :image, optional: true
    belongs_to :user, optional: true
    
    has_many :calendar_dates
    has_many :bookings

    has_many :rates, dependent: :destroy

    validates :num_of_bookings, presence: true

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
