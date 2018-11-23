# frozen_string_literal: true

module UsersHelper
  # Returns the avatar and name for the given user .
  def avatar_for(user)
    if user.avatar.attached?
      avatar_url = user.avatar.variant(resize: "100x100")
    else
      avatar_url = "/images/default_avatar.jpg"
    end
    link_to(image_tag(avatar_url, alt: user.first_name, class: "avatar img-circle"), user)
  end
end
