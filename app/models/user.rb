class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :email, uniqueness: true
  before_save { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 } ,on: :create
  has_many :favorites, dependent: :destroy
  has_many :favorite_blogs, through: :favorites, source: :blog
  has_many :blogs
  mount_uploader :proimage, ImageUploader
end
