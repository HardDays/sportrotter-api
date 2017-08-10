class Professional < ApplicationRecord
    belongs_to :user

    belongs_to :diploma, class_name: 'Image', optional: true
    belongs_to :background, class_name: 'Image', optional: true
end
