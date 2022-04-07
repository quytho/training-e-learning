class Course < ApplicationRecord
    belongs_to :user_course

    has_many :lessons
end
