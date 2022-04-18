class Word < ActiveRecord::Base
    has_many    :user_words
    belongs_to  :lesson
    belongs_to  :course
end
