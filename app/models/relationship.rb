class Relationship < ApplicationRecord

  #リレーションの設定（今までの書き方+クラス名(モデル名)の指定）
  #followerというオブジェクト名でUserモデルとのリレーションを行う設定
  belongs_to :follower, class_name: "User"
  #上記と同様の考え方
  belongs_to :followed, class_name: "User"

end
