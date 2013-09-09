# encoding: utf-8

require "unicode_utils/downcase"
require 'tweetstream'
require 'yaml'
require 'pg'

config_auth   = YAML::load(File.open("#{File.expand_path(File.dirname(__FILE__))}/../config/credentials.yml"))

TweetStream.configure do |config|
  config.consumer_key       = config_auth['consumer_key']
  config.consumer_secret    = config_auth['consumer_secret']
  config.oauth_token        = config_auth['oauth_token']
  config.oauth_token_secret = config_auth['oauth_token_secret']
  config.auth_method        = :oauth
end


INSERT_TWEET   = "INSERT INTO tweets   (created_at,tweet,raw) VALUES (NOW(),$1,$2) RETURNING id"
INSERT_HASHTAG = "INSERT INTO hashtags (created_at,text)      VALUES (NOW(),$1)    RETURNING id"

INSERT_TWEET_HASHTAG = "INSERT INTO tweet_hashtags (tweet_id,hashtag_id) VALUES "

conn = PG.connect( user: 'dev', dbname: 'tweetstream_development' )

track_phrases = []
conn.exec('SELECT id,text FROM track_phrases').each_row do |id,text|
  track_phrases << text
end
puts "Track phrases: " + track_phrases.inspect

hashtags_known = {}
conn.exec('SELECT id, text FROM hashtags').each_row do |id,hashtag|
  hashtags_known[hashtag] = id
end
puts "Known hashtags: " + hashtags_known.inspect

client = TweetStream::Client.new

client.on_error do |message|
  puts message
end


client.track(track_phrases) do |status|
#  puts status.attrs.inspect
  puts "#{status.user.name}: #{status.text}"
  tweet = status.text
  raw = status.attrs.inspect
  tweet_id = conn.exec_params( INSERT_TWEET, [tweet,raw] )[0]['id']

  hashtags_sql = status.attrs[:entities][:hashtags].map do |ht|
    hashtag = UnicodeUtils.downcase(ht[:text])
    # если такого hashtag ещё нет - вставить в таблицу и запомнить его id
    hashtag_id = hashtags_known[hashtag] ||= conn.exec_params( INSERT_HASHTAG, [hashtag] )[0]['id']
    ['(',tweet_id,',',hashtag_id,')'].join
  end
  conn.exec_params( [INSERT_TWEET_HASHTAG, hashtags_sql.join(',')].join ) if hashtags_sql.any?
end

