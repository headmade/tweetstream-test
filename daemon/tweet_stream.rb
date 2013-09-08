# encoding: utf-8

require 'tweetstream'
require 'yaml'
require 'pg'
require "unicode_utils/downcase"

config_auth   = YAML::load(File.open("#{File.expand_path(File.dirname(__FILE__))}/../config/credentials.yml"))
config_filter = YAML::load(File.open("#{File.expand_path(File.dirname(__FILE__))}/../config/filter.yml"))
puts "FILTER: " + config_filter.inspect

TweetStream.configure do |config|
  config.consumer_key       = config_auth['consumer_key']
  config.consumer_secret    = config_auth['consumer_secret']
  config.oauth_token        = config_auth['oauth_token']
  config.oauth_token_secret = config_auth['oauth_token_secret']
  config.auth_method        = :oauth
end

CREATE_TABLE_TWEET = <<EOS
DROP TABLE IF EXISTS tweets_raw CASCADE;
CREATE TABLE tweets_raw (
  id          SERIAL PRIMARY KEY,
  created_at  TIMESTAMP       NOT NULL,
  tweet       VARCHAR         NOT NULL,
  raw         TEXT            NOT NULL
);
EOS

CREATE_TABLE_HASHTAGS = <<EOS
DROP TABLE IF EXISTS hashtags CASCADE;
CREATE TABLE hashtags (
  id          SERIAL PRIMARY KEY,
  created_at  TIMESTAMP       NOT NULL,
  hashtag     VARCHAR         NOT NULL
);
CREATE UNIQUE INDEX ON hashtags(hashtag);
EOS

CREATE_TABLE_TWEET_HASHTAGS = <<EOS
DROP TABLE IF EXISTS tweet_hashtags;
CREATE TABLE tweet_hashtags (
  id         SERIAL PRIMARY KEY,
  tweet_id   INTEGER NOT NULL REFERENCES tweets_raw(id) ON DELETE CASCADE,
  hashtag_id INTEGER NOT NULL REFERENCES hashtags(id)   ON DELETE CASCADE
);
CREATE INDEX ON tweet_hashtags(hashtag_id);
CREATE INDEX ON tweet_hashtags(tweet_id);
EOS

INSERT_TWEET   = "INSERT INTO tweets_raw (created_at,tweet,raw) VALUES (NOW(),$1,$2) RETURNING id"
INSERT_HASHTAG = "INSERT INTO hashtags   (created_at,hashtag) VALUES (NOW(),$1) RETURNING id"

INSERT_TWEET_HASHTAG = "INSERT INTO tweet_hashtags  (tweet_id,hashtag_id) VALUES "

conn = PG.connect( user: 'tweetstream_test', dbname: 'tweetstream_test' )
conn.exec(CREATE_TABLE_TWEET)
conn.exec(CREATE_TABLE_HASHTAGS)
conn.exec(CREATE_TABLE_TWEET_HASHTAGS)

hashtags_known = {}
res = conn.exec('SELECT id, hashtag FROM hashtags')
res.each_row do |id,hashtag|
puts hashtag.inspect
  hashtags_known[hashtag] = id
end

puts "Known hashtags: " + hashtags_known.inspect

client = TweetStream::Client.new

client.on_error do |message|
  puts message
end


#track_words = %w(it_ulsk ulsk dtp dengoroda мэрмосквы)
#track_words = %w(мэрмосквы выборымэра чистыевыборы говорючестно выборыМО 8сентября)
track_words = config_filter['words']
puts "Tracking: " + track_words

client.track(track_words) do |status|
#  puts status.attrs.inspect
  tweet = status.text
  puts "#{status.user.name}: #{tweet}"
  raw = status.attrs.inspect
  res = conn.exec_params( INSERT_TWEET, [tweet,raw] )
  tweet_id = res[0]['id']

  hashtags_sql = status.attrs[:entities][:hashtags].map do |ht|
    hashtag = UnicodeUtils.downcase(ht[:text])
    hashtag_id = hashtags_known[hashtag]
    unless hashtag_id
      hashtag_id = conn.exec_params( INSERT_HASHTAG, [hashtag] )[0]['id']
      hashtags_known[hashtag] = hashtag_id
    end
    ['(',tweet_id,',',hashtag_id,')'].join
  end
  conn.exec_params( INSERT_TWEET_HASHTAG + hashtags_sql.join(',') ) if hashtags_sql.any?
end

