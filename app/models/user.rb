class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #アソシエーションの関係（1:Nの1側）
  has_many :books, dependent: :destroy

  #BookCommentモデルのidとの関連付け
  has_many :book_comments, dependent: :destroy
  #Favoriteモデルのidとの関連付け
  has_many :favorites, dependent: :destroy

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

end
