class Lesson < ActiveRecord::Base
  belongs_to  :course
  has_one     :practice
  has_many    :user_words
  has_many    :words, :dependent => :destroy
  scope :order_name_lesson, -> { order(name: :ASC)}
  # scope :order_course_name_lesson, -> { order(lesson.course.name: :ASC)}
end
