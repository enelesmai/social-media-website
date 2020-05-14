module UsersHelper
  def request_friend(user)
    html = ''
    unless current_user.requested?(user) || current_user.pending?(user) || current_user.friend?(user) || current_user == user
      html += link_to ' | Invite to friendship', friendships_path(user: user), method: :post, class: 'label-status'
    end
    html.html_safe
  end

  def pending_invitation(user)
    html = ''
    friendship = current_user.get_friendship(user)
    if current_user.pending?(user)
      html += link_to ' | Accept', friendship_path(friendship, user: user, confirmed: true), method: :put, class: 'label-success'
      html += link_to ' | Decline', friendship_path(friendship, user: user, confirmed: false), method: :put, class: 'label-danger'
    end
    html.html_safe
  end

  def label_friendship(user)
    html = ''
    html += label_tag 'Requested friendship', nil, class: 'label-status' if current_user.requested?(user)
    html += label_tag 'You are already friends!', nil, class: 'label-status' if current_user.friend?(user)
    html.html_safe
  end
end
