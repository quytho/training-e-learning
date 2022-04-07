class UserLesson < ApplicationRecord
    belongs_to :user_lesson

    has_many :users
    has_many :lessons
end
