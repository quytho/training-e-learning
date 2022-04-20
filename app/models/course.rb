class Course < ActiveRecord::Base
  has_many :user_courses
  has_many :lessons, :dependent => :destroy
  has_many :words
end
