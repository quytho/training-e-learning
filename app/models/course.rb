class Course < ApplicationRecord
    has_many :user_courses
    has_many :lessons
end
