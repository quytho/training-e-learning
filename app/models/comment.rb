class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  
  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
  belongs_to :parent, class_name: 'Comment', optional: true

  default_scope -> { order(created_at: :desc)}
  validates :body, presence: true
  validates :user_id, presence: true
  validates :course_id, presence: true
end
