class Lesson < ApplicationRecord
    belongs_to :course
    belongs_to :Practice

    has_many: words
end
