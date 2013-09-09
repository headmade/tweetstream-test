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

TrackPhrase.create(phrases.map{ |p| { text: p }  })

