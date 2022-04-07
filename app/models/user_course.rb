class UserCourse < ApplicationRecord
    has_many :users
    has_many :courses


end
