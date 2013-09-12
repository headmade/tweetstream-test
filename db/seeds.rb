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

# TODO
# - придумываем около 15 тем, собирающие по 10, 50, 100, 200 тыс твитов
# TweetHashtag.select("hashtag_id, count(hashtag_id) as total").group(:hashtag_id).order("total DESC").limit(100).offset(offset).map { |i| [i.id, i.hashtag.text, i.total] }
topics = {
  'Выборы' => %w(msk moskva чистыевыборы навальный navalny навальныйжулик собянин собянинмэр агитациясобянина мэрмосквы мэрмосква выборыгубернаторамо выборымо выборы2013 msk080 россиязанавльного выборымэра навальныйпроиграл честнаявласть легитимнаявласть легитимность),
  'Путин' => %w(путин президент ввп планпутина пжив),
  'Apple' => %w(айфон айпад аймак макбук iphone ipad imac macbook ipadgames apple iphone5s iphone5c),
  'США'   => %w(сша обама барак баракобама obama barak barakobama usa us америка 11сентября),
  'Казань' => %w(казань казанский казане казанскаяосень kazan20 rubinkazan kazan2013 kazansmartcity kznportal kazan),
  'Спорт' => %w(футбол чм2014 березуцкий спорт новостиспорта спорт предстоящиеспортивныесобытия конныйспорт велоспорт спортивнаясреда спортивное спортсмен спортфутбол спортобъектыkznportal общественныйвелотранспорт спортклуб живемстуденческимспортом спортибизнес спортврегионах спортолимпизм sport sports eurosport sportnews),
  'Олимпиада' => %w(олимпиада олимпиада2014 олимпиадасочи2014 олимпизмсочи2014 олимпийский олимпиаде спортолимпизм сочи сочи2014 sochi sochi2014 sochigames olympic olympics),
  'Россия' => %w(россия россии russia ru рф ru_ff russian rusnovosti spb piter питер санктпетербург петербург saintpetersburg stpetersburg moskva msk мск подмосковье мо ulsk иркутск краснодар vladikavkaz новосибирск пермь ростов омск тюмень волгоград),
  'TV' => %w(tv тв телек голос телевидение)
}

# TODO: сделать вложенные топики
topics['Политика'] = %w(дума медведев грызлов иванов сердюков политика болотная митинг кпрф kremlin lavrov единаяроссия едро пжив) + topics['Выборы'] + topics['Путин']
topics['Татарстан'] = %w(татарстан татарстане tatarstan минниханов) + topics['Казань']
topics['Мировая Политика'] = %w(g20 сирия сирии syria украина minsk минск bahrain kuwait израиль россияизраиль iran assad london ukraine lavrov europe арабскийпереворот) + topics['США']
topics['Спорт'] += topics['Олимпиада']
topics['Россия'] += topics['Татарстан']

puts 'Импорт обзорных тем'

topics.each do |title, tags|
  topic = Topic.find_or_create_by title: title
  topic.hashtags = tags.map { |tag| Hashtag.find_or_create_by text: tag }
  puts "#{topic.title}:\t#{topic.save ? 'ok' : 'err'}:\t#{tags}"
end

puts 'Импорт завершен.'

