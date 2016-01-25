module Admin::UsersHelper
  def sort_users_by_role(users)
    sorted = []
    visited = {}

    role_order.each do |role_name|
      users.each do |user|
        next if visited[user.id]

        if user.has_role? role_name
          sorted.push( user )

          visited[user.id] = true
        end
      end
    end

    return sorted
  end

  def role_order
    User.available_role_names
  end
end
