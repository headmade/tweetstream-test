# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

phrases =<<EOS
мэрмосквы
выборымэра
чистыевыборы
говорючестно
выборыМО
8сентября
msk0809
УИК
Болотной
Единая Россия
Справедливая Россия
Яблоко
КПРФ
Россия
США
Америка
Путин
Медведев
Собянин
Навальный
Москва
Moscow
Питер
Spb
Казань
ulsk
it_ulsk
айфон
айпад
макбук
EOS

phrases = phrases.split("\n")
phrases.each do |p|
  TrackPhrase.find_or_create_by text: p
end

topics = {
  "Выборы" => %w(msk moskva чистыевыборы),
  "Политика" => %w(навальный собянин),
  "Путин" => %w(путин президент)
}
p "Импорт тем"
topics.each do |name, tags|
  topic = Topic.find_by title: name
  topic ||= Topic.new title: name
  topic.hashtags.clear
  tags.each do |tag|
    hashtag = Hashtag.find_or_create_by text: tag
    topic.hashtags << hashtag
  end
  p "#{topic.title}: #{topic.save}"
end
p "Импорт завершен."
