class Item < ActiveRecord::Base
  #----------------アイテムのオーナーシップの設定--------------------
  #　dependent : :destoryoyにすると親オブジェクト（オーナーシップ）が削除されたときにこのキーも削除するようにできる
  #多くの（ユーザ： 商品id）の組み合わせを持っている，item_idで検索することができ， ユーザー情報を取得できる
  has_many :ownerships  , foreign_key: "item_id" , dependent: :destroy
  #ownewrshipsは(user_id : item_id)の中間テーブル
  has_many :users , through: :ownerships
  #--------------------------------------------------

  
  #--------------------------------------------------
  has_many :wants , foreign_key: "item_id" , dependent: :destroy
  #has_many :want_users　　　want_usersという変数に配列でデータを入れてください
  #through: :wants_テーブル(item:user)に存在するUser_idが一致するもの全てを取得する
  has_many :want_users ,through: :wants ,source: :user
  #--------------------------------------------------
  
  
  #----------------------クラスネーム指定は絶対----------------------------
  has_many :haves, class_name:'Have' , foreign_key: "item_id" , dependent: :destroy
  has_many :have_users ,through: :haves ,source: :user
  #--------------------------------------------------
  
end