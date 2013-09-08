# encoding: utf-8

require 'tweetstream'
require 'yaml'
require 'pg'

auth = YAML::load(File.open("#{File.expand_path(File.dirname(__FILE__))}/credentials.yml"))

TweetStream.configure do |config|
  config.consumer_key       = auth['consumer_key']
  config.consumer_secret    = auth['consumer_secret']
  config.oauth_token        = auth['oauth_token']
  config.oauth_token_secret = auth['oauth_token_secret']
  config.auth_method        = :oauth
end

CREATE_TABLE = <<EOS
DROP TABLE IF EXISTS tweets_raw;
CREATE TABLE tweets_raw (
  id SERIAL PRIMARY KEY,
  created_at  TIMESTAMP       NOT NULL,
  tweet       VARCHAR         NOT NULL,
  hashtags    VARCHAR         NOT NULL,
  track_words TEXT            NOT NULL,
  raw         TEXT            NOT NULL
);
EOS

INSERT_TWEET = "INSERT INTO tweets_raw (created_at,tweet,hashtags,track_words,raw)
                                 VALUES(NOW(),$1,$2,$3,$4)"

conn = PG.connect( user: 'tweetstream_test', dbname: 'tweetstream_test' )
conn.exec(CREATE_TABLE)

client = TweetStream::Client.new

client.on_error do |message|
  puts message
end


track_words = %w(it_ulsk ulsk dtp dengoroda мэрмосквы)
track_words = %w(мэрмосквы выборымэра чистыевыборы говорючестно выборыМО 8сентября)
puts "Tracking: " + track_words.join(',')

client.track(track_words) do |status_obj|
  puts status_obj.attrs.inspect
  tweet = status_obj.text
  hashtags = status_obj.attrs[:entities][:hashtags].map{ |ht| ht[:text] }.inspect
  raw = status_obj.attrs.inspect
  conn.exec_params( INSERT_TWEET, [tweet,hashtags,track_words,raw] )
end

