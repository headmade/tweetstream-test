json.array!(@hashtags) do |hashtag|
  json.extract! hashtag, :text
  json.url hashtag_url(hashtag, format: :json)
end
