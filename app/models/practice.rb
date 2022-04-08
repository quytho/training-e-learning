class Practice < ApplicationRecord
    belongs_to  :user
    has_one     :lesson
end
