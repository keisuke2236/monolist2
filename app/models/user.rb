class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :following_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  
  has_many :followed_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followed_users, through: :followed_relationships, source: :follower

  #ユーザーは複数のフォローしているユーザーを所持する（オーナーシップ）
  has_many :ownerships , foreign_key: "user_id", dependent: :destroy
  
  #多くのアイテム：ユーザー
  has_many :items ,through: :ownerships
  
  #親クラスを継承した持っているモデルはUserくらすから　いつでも利用できるよ
  #この人が持っているもの，を表現できる
  #
  has_many :haves, class_name: "Have", foreign_key: "user_id", dependent: :destroy
  has_many :have_items , through: :haves, source: :item

  #こちらも同じく　　この人が欲しいものを表現
  #親のオーナーシップモデルからtypeがwantを引っ張ってこれる
  has_many :wants, class_name: "Want", foreign_key: "user_id", dependent: :destroy
  has_many :want_items , through: :wants, source: :item

  #	itemをwantする。
  def want(item)
    following_relationships.find_or_create_by(followed_id: item.id)
  end
  
  def want?(item)
    following_users.include?(item)
  end
  
  def unwant(item)
    following_relationships = following_relationships.find_by(followed_id: item.id)
  end
  
  def have(item)
  end
  def have?(item)
  end
  def unhave(item)
  end



  # 他のユーザーをフォローする
  def follow(other_user)
    
    following_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    
    following_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    
    following_users.include?(other_user)
  end

  ## TODO 実装
  def have(item)
    self.haves.find_or_create_by(item: item)
    
  end

  def unhave(item)
    @deluser = self.haves.find_by(item: item)
    @deluser.destroy
  end

  def have?(item)
    have_items.find_by(item_code: item["itemCode"])!=nil
  end

#------------------------------------------------
  def want(item)
    self.wants.find_or_create_by(item: item)
  end

  def unwant(item)
    @deluser = self.wants.find_by(item: item)
    @deluser.destroy
  end

  def want?(item)
    want_items.find_by(item_code: item["itemCode"])!=nil
  end
end
