class Course < ActiveRecord::Base
  has_many :user_courses
  has_many :lessons, dependent: :destroy
  has_many :words
  has_many :comments, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
  scope :order_name_course, -> { order(id: :ASC) }
  scope :search_name, ->(name) { where("LOWER(name) LIKE ?", "%#{name}%") if name.present? }
  scope :search, lambda { |params|
    search_name(params[:name])
  }
end
