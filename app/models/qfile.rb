class Qfile < ApplicationRecord
  belongs_to :user

  mount_uploader :src, QfileUploader
end
