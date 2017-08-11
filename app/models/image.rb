class Image < ApplicationRecord
    has_one :user
    has_one :activity
end
