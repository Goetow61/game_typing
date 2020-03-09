class Qfile < ApplicationRecord
  belongs_to :user
  has_many :results
  mount_uploader :src, QfileUploader

  # rails enumで検索 単語が1、文章が2で入る
  enum category: [:'英語-単語', :'英語-文章']
end
