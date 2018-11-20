class SearchController < ApplicationController
  def index
    search_text = params[:search_text]
    @users = search_text.present? ? User.select('id', 'first_name').where('UPPER(first_name) LIKE UPPER(?)', "%#{search_text}%").where.not(['first_name= ?', current_user.first_name]) : []
    render json: @users
  end
end
