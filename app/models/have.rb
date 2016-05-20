#親クラスを継承したモデル定義
#rails generate model Have --parent Ownership 的な感じで作った
#作ったらuser.rbの方でこのクラスをつかえるように関連つけよう

class Have < Ownership
    
end
