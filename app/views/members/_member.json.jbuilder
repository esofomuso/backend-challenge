json.extract! member, :id, :name, :url, :short_url, :created_at, :updated_at
json.url member_url(member, format: :json)
