class User < ApplicationRecord
    belongs_to :user_course
    belongs_to :user_lesson
    belongs_to :user_word

    belongs_to :Practice


end
