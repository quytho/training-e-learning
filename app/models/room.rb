class Room < ActiveRecord::Base
  after_create_commit {broadcast_append_to "rooms"} 
  validates_uniqueness_of :name
  has_many :messages
  has_many :participants, dependent: :destroy
  scope :public_rooms, -> { where(is_private: false) }
  def broadcast_if_public
    broadcast_append_to "rooms" unless self.is_private
  end
  
  def self.create_private_room(users, room_name)
    single_room = Room.create(name: room_name, is_private: true)
    users.each do |user|
      Participant.create(user_id: user.id, room_id: single_room.id )
    end
    single_room
  end
end
