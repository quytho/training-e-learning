class Word < ApplicationRecord
    has_many    :user_words
    belongs_to  :lesson
end
