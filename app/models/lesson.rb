class Lesson < ActiveRecord::Base
  belongs_to  :course
  has_one     :practice
  has_many    :user_words
  has_many    :words, dependent: :destroy
  has_many    :questions, dependent: :destroy
  validates :name, presence: true
  validates :course_id, presence: true
  scope :order_name, -> { order(name: :ASC) }
  scope :order_name_lesson, -> { order(id: :ASC) }
  scope :search_name, ->(name) { where("LOWER(name) LIKE ?", "%#{name}%") if name.present? }
  scope :search, lambda { |params|
    search_name(params[:name])
  }
end
