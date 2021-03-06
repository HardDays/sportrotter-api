class User < ApplicationRecord
    
    validates :email, uniqueness: true, optional: false
	validates :password, optional: false

    validates_inclusion_of :gender, in: ['male', 'female', nil]
    validates_inclusion_of :user_type, in: ['professional', 'client']

    belongs_to :image, optional: true

    has_one :client, dependent: :destroy
    has_one :professional, dependent: :destroy

    has_many :tokens, dependent: :destroy
    has_many :activities, dependent: :destroy

    has_many :sent_messages, foreign_key: "from_id", class_name: "Message"
    has_many :received_messages, foreign_key: "to_id", class_name: "Message"
    has_many :bookings

    has_many :rates, dependent: :destroy

    geocoded_by :address, latitude: :lat, longitude: :lng 
    reverse_geocoded_by :lat, :lng, address: :address
    after_validation :geocode
    

    def self.get_hash(password) 
        return Digest::SHA256.hexdigest(password)
    end

    before_create do
		self.password = User.get_hash(self.password)
	end

    def serializable_hash options=nil
		attrs = {}
		if user_type == 'professional'
			attrs[:background_id] = professional.background_id
            attrs[:diploma_id] = professional.diploma_id
            attrs[:address] = professional.address
            attrs[:phone] = professional.phone
            attrs[:description] = professional.description
  		end
  		super.merge(attrs)
	end
end
