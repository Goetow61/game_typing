class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :qfiles, dependent: :destroy
  has_many :results, dependent: :destroy
end
