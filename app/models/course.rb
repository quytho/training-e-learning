class Course < ActiveRecord::Base
    has_many :user_courses
    has_many :lessons
    has_many :words
end
