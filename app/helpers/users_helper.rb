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
    if current_user.pending?(user)
      html += link_to ' | Accept', friendships_path(user: user), method: :post, class: 'profile-link'
      html += link_to ' | Decline', friendships_path(user: user), method: :post, class: 'profile-link'
    end
    html.html_safe
  end
end
