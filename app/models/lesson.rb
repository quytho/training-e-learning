class Lesson < ActiveRecord::Base
  belongs_to  :course
  has_one     :practice
  has_many    :user_words
  has_many    :words
  scope :order_name, -> { order(name: :ASC)}
  validates :name, uniqueness: true, presence: true
end
