class User < ActiveRecord::Base
  attr_accessor :reset_token
  
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

  class << self
    def digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string,cost: cost)
    end

    def new_token 
        SecureRandom.urlsafe_base64
    end
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def authenticated? (attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
end
