# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 既定のユーザ(トップページにデフォルト表示させておく問題を登録するユーザ)
User.create(nickname: '既定ユーザ', email: ENV['GMAIL_ADDRESS'], password: [*'A'..'Z', *'a'..'z', *0..9].shuffle[0..7].join )

# 既定のユーザがデフォルトで登録しておく問題
id = User.where(email: ENV['GMAIL_ADDRESS']).select(:id)
title = ['abide - certification 200語','certify - drill 200語','drought - indoor 200語','induction - painter 200語','pamphlet - satellite 200語','satisfactory - zoo 259語','英語例文 200件 1','英語例文 200件 2','英語例文 200件 3','英語例文 200件 4']
overview = ['THE TOEIC SERVICE LIST 1.1の内、 abide　から　certification　までの 200語を抜き出したもの','THE TOEIC SERVICE LIST 1.1の内、 certify　から　drill　までの 200語を抜き出したもの','THE TOEIC SERVICE LIST 1.1の内、 drought　から　indoor　までの 200語を抜き出したもの','THE TOEIC SERVICE LIST 1.1の内、 induction　から　painter　までの 200語を抜き出したもの','THE TOEIC SERVICE LIST 1.1の内、 pamphlet　から　satellite　までの 200語を抜き出したもの','THE TOEIC SERVICE LIST 1.1の内、 satisfactory　から　zoo　までの 259語を抜き出したもの','Tatoeba 文章と翻訳のコレクション(https://tatoeba.org/jpn/) から英語の例文を取り出して、200件毎に保存したものです。  日本語は、英語の例文をGoogle翻訳したものなので、 正しく訳せていない場合があります。','Tatoeba 文章と翻訳のコレクション(https://tatoeba.org/jpn/) から英語の例文を取り出して、200件毎に保存したものです。  日本語は、英語の例文をGoogle翻訳したものなので、 正しく訳せていない場合があります。','Tatoeba 文章と翻訳のコレクション(https://tatoeba.org/jpn/) から英語の例文を取り出して、200件毎に保存したものです。  日本語は、英語の例文をGoogle翻訳したものなので、 正しく訳せていない場合があります。','Tatoeba 文章と翻訳のコレクション(https://tatoeba.org/jpn/) から英語の例文を取り出して、200件毎に保存したものです。  日本語は、英語の例文をGoogle翻訳したものなので、 正しく訳せていない場合があります。','THE TOEIC SERVICE LIST 1.1の内、 abide　から　certification　までの 200語を抜き出したもの']
src = ['word_001.csv','word_002.csv','word_003.csv','word_004.csv','word_005.csv','word_006.csv','sentence_001.csv','sentence_002.csv','sentence_003.csv','sentence_004.csv']
category = [0,0,0,0,0,0,1,1,1,1]

count = 0
while(count < title.length) do
  Qfile.create(title: title[count], overview: overview[count], src: open("#{Rails.root}/db/csv/#{src[count]}"), category: category[count], user_id: id.ids[0] )
  count = count + 1
end
