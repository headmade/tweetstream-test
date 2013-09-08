# encoding: utf-8

require 'tweetstream'
require 'yaml'
auth = YAML::load(File.open("#{File.expand_path(File.dirname(__FILE__))}/credentials.yml"))

TweetStream.configure do |config|
  config.consumer_key       = auth['consumer_key']
  config.consumer_secret    = auth['consumer_secret']
  config.oauth_token        = auth['oauth_token']
  config.oauth_token_secret = auth['oauth_token_secret']
  config.auth_method        = :oauth
end

client = TweetStream::Client.new

client.on_error do |message|
  puts message
end


track_words = %w(it_ulsk ulsk dtp dengoroda мэрмосквы)
track_words = %w(мэрмосквы выборымэра чистыевыборы говорючестно выборыМО 8сентября)
puts "Tracking: " + track_words.join(',')

client.track(track_words) do |status|
  puts status.inspect
end

