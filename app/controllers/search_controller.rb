# frozen_string_literal: true

# Controller for searching
class SearchController < ApplicationController
  def index
    search_text = params[:search_text]
    if search_text.start_with?('#')
      search_text = search_text.slice(1..-1)
      @posts = ActsAsTaggableOn::Tag.select('id','name').where("name like (?)","%#{search_text}%")
      # @posts = Post.tagged_with(search_text, any: true)
      # followed_users = current_user.following_ids
      # @posts = @posts.where(user_id: followed_users)
                    #  .or(@posts.where(is_public: true))      
      # render 'home/tagged_feeds'
      render json: @posts

    else
      @users = search_text.present? ?
                 User.select('id', 'first_name')
                     .where('UPPER(first_name) LIKE UPPER(?)',
                            "%#{search_text}%")
                     .where.not(['first_name= ?', current_user.first_name]) : []
      render json: @users
    end
  end
end
@users = []
