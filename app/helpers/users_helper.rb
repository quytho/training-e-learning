module UsersHelper
  def user_image(user)
    user.image&.url || 'avatar.png'
  end

  def findRelationshipId(userId)
    current_user.active_relationships.find_by(followed_id: userId).id
  end
end
