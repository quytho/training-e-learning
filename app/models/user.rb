class User < ActiveRecord::Base
  has_many :user_courses
  has_many :user_lessons
  has_many :user_words
  has_many :practices

  before_save {self.email = email.downcase }
  validates :name,length: {maximum:50},presence:true
  validates :email,length: {maximum:100}, presence: true, format: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
            uniqueness: {case_sensitive:false}
  has_secure_password
  mount_uploader :image, PictureUploader
  PASSWORD_FORMAT = /\A
    (?=.{8,})          
    (?=.*\d)           
  /x
  validates :password, length: {:within => 8..40}, format: { with: PASSWORD_FORMAT }
end
