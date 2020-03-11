class Result < ApplicationRecord
  belongs_to :user
  belongs_to :qfile
  counter_culture :qfile
end
