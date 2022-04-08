class Lesson < ApplicationRecord
    belongs_to  :course
    has_one     :practice
    has_many    :user_words
    has_many    :words
end
