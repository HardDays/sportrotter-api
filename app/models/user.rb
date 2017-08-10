class User < ApplicationRecord

    validates :email, uniqueness: true, optional: false
	validates :password, optional: false

    belongs_to :gender, optional: true
    belongs_to :image, optional: true

    has_one :client, dependent: :destroy
    has_one :professional, dependent: :destroy

    has_many :tokens, dependent: :destroy

    before_create do
		self.password = Digest::SHA256.hexdigest(self.password)
	end

	before_update do
		self.password = Digest::SHA256.hexdigest(self.password)
	end

    def serializable_hash options=nil
		attrs = {}
		if professional != nil
            attrs[:user_type] = :professional
            #attrs[:professional] = professional
			attrs[:background_id] = professional.background_id
            attrs[:diploma_id] = professional.diploma_id
            attrs[:address] = professional.address
            attrs[:phone] = professional.phone
            attrs[:description] = professional.description
        else
            attrs[:user_type] = :client
  		end
  		super.merge(attrs)
	end
end
