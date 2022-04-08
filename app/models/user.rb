class User < ApplicationRecord
    has_many :user_courses
    has_many :user_lessons
    has_many :user_words
    has_many :practices
end
