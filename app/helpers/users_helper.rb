module UsersHelper
  def request_friend(user)
    html = ''
    unless current_user.requested?(user) || current_user.pending?(user) || current_user == user
      html += link_to ' | Invite to friendship', friendships_path(user: user), method: :post, class: 'profile-link'
    end
    html.html_safe
  end

  def requested_friendship(user)
    html = ''
    html += label_tag 'Requested friendship' if current_user.requested?(user)
    html.html_safe
  end

  def pending_invitation(user)
    html = ''
    friendship = current_user.get_friendship(user)
    if current_user.pending?(user)
      html += link_to ' | Accept', friendship_path(friendship, user: user, confirmed: true), method: :put, class: 'profile-link'
      html += link_to ' | Decline', friendship_path(friendship, user: user, confirmed: false), method: :put, class: 'profile-link'
    end
    html.html_safe
  end
end
