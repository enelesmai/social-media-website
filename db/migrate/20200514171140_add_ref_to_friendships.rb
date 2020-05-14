class AddRefToFriendships < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :friendships, :users
    add_foreign_key :friendships, :users, column: "friend_id"
  end
end
