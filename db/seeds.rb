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
  'Выборы' => %w(msk moskva чистыевыборы навальный собянин мэрмосквы выборымо выборы2013 msk0809),
  'Путин' => %w(путин президент ввп планпутина)
}

# TODO: сделать вложенные топики
topics['Политика'] = %w(дума медведев грызлов иванов сердюков политика) + topics['Выборы'] + topics['Путин']

puts 'Импорт обзорных тем'

topics.each do |title, tags|
  topic = Topic.find_or_create_by title: title
  topic.hashtags = tags.map { |tag| Hashtag.find_or_create_by text: tag }
  puts "#{topic.title}:\t#{topic.save ? 'ok' : 'err'}:\t#{tags}"
end

puts 'Импорт завершен.'

