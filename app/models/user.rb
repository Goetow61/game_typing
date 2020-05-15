class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :qfiles, dependent: :destroy
  has_many :results, dependent: :destroy

  def self.guest
    find_or_create_by!(email: 'guest@guest') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = 'ゲスト'
    end
  end

end
