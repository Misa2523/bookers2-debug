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


  #あるユーザーがフォローしている人（フォロイー）の一覧を取得するアソシエーション
    #relationshipsというオブジェクト名で、Relationshipモデルとfollower_idを外部キーとしてアソシエーションを行う
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    #followingsというオブジェクト名で、上記で設定したrelationshipsというアソシエーションを利用してRelationshipモデルを参照し、参照先のRelationshipモデルのfollowedというアソシエーションを行う
  has_many :followings, through: :relationships, source: :followed

  #あるユーザーをフォローしている人（フォロワー）の一覧を取得するアソシエーション
    #reverse_of_relationshipsというオブジェクト名で、Relationshipモデルとfollowed_idを外部キーとしてアソシエーションを行う
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
    #followersというオブジェクト名で、1で設定したreverse_of_relationshipsというアソシエーションを利用してRelationshipモデルを参照し、参照先のRelationshipモデルのfollowerというアソシエーションを行う
  has_many :followers, through: :reverse_of_relationships, source: :follower


  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end


  #指定したユーザーをフォローする（active_relationshipsを経由して指定したユーザーをフォロー）
  def follow(user)
    relationships.create(followed_id: user.id)
  end

  #指定したユーザーのフォローを解除する
  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  #指定したユーザーをフォローしているかどうかを判定
  def following?(user)
    followings.include?(user)
  end

  #検索機能のプルダウンメニューの設定
  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content+'%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%'+content)
    else
      User.where('name LIKE ?', '%'+content+'%')
    end
  end

end
