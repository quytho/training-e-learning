class Word < ApplicationRecord
    belongs_to :user_word
    belongs_to :lesson

end
