# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 既定のユーザがデフォルトで登録しておく問題
id = User.where(email: ENV['GMAIL_ADDRESS']).select(:id)
title = ['英語例文 3〜30文字 100件 5','英語例文 3〜30文字 100件 6','英語例文 3〜30文字 100件 7','英語例文 3〜30文字 100件 8']
overview = 'Tatoeba 文章と翻訳のコレクション(https://tatoeba.org/jpn/) Japanese-English (48955件)から100件。2020-03-15版。文字数は3〜30文字'
src = ['sentence_005.csv','sentence_006.csv','sentence_007.csv','sentence_008.csv']
category = [1,1,1,1]

count = 0
while(count < title.length) do
  Qfile.create(title: title[count], overview: overview, src: open("#{Rails.root}/db/csv/#{src[count]}"), category: category[count], user_id: id.ids[0] )
  count = count + 1
end

title = ['なんで笑ってるの？','がばっと気合を入れて身を起こした。','カメラを見ていてね。',
  '冗談だろう！','今日のトムは調子が良さそうだ。','トムってフランス語もやってるの？',
  '彼女は明かりをつけた。','わたしは６階に住んでいる。','コーヒーのおかわりを下さい。',
  'それが現実だ。','そういうわけで遅くなったのです。','タクシーで行きませんか。',
  'トムは仕事に夢中になっている。','いつまでこちらにいらっしゃるんですか？',
  '私は毎日10キロ走っています。','あなたの部屋はどこですか。','あり得ねぇー。',
  '私は一人で全てをやらなければならなかった。']
overview = ['Tatoeba 文章と翻訳のコレクション(https://tatoeba.org/jpn/) Japanese-English (48955件)から100件。2020-03-15版。文字数は3〜30文字',
  'EF Education First - Global Site (English)(https://www.ef.com/wwen/) 3000 most common words in English | Learn English | EF から100件。']
src = ['free_sentence_001.csv','free_sentence_002.csv','free_sentence_003.csv',
  'free_sentence_004.csv','free_sentence_005.csv','free_sentence_006.csv',
  'free_sentence_007.csv','free_sentence_008.csv','free_word_001.csv',
  'free_word_002.csv','free_word_003.csv','free_word_004.csv',
  'free_word_005.csv','free_word_006.csv','free_word_007.csv',
  'free_word_008.csv','free_word_009.csv','free_word_010.csv']
category = [1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

count = 0
while(count < title.length) do
  # user_idランダムだが、既定ユーザーになってしまうと表示位置が変わってしまうので手動修正すること。
  overview1 = count<8 ? overview[0] : overview[1]
  # binding.pry
  Qfile.create(title: title[count], overview: overview1, src: open("#{Rails.root}/db/csv/#{src[count]}"), category: category[count], user_id: User.offset( rand(User.count) ).first.id)
  count = count + 1
end
