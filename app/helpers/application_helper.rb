# frozen_string_literal: true

# helper  module for user
module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = 'Ruby on Rails Tutorial Sample App'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def name(user)
    user.first_name + ' ' + user.last_name
  end
end
