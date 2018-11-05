json.extract! post, :id, :title, :content, :likes, :comments, :is_public, :is_drafted, :tags, :created_at, :updated_at
json.url post_url(post, format: :json)
