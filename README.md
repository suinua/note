# note
BLoCアーキテクチャとFirebaseでメモAPP

# 環境構築
Firebaseの準備（自分はFirebaseに付いて詳しくないので...）
https://firebase.google.com/docs/flutter/setup?hl=ja

# アーキテクチャ
データはblocで管理。

**現状**
□はページ
◯はウィジェット
![architecture](https://github.com/suinua/note/blob/master/architecture.png)

### 入れ子状のデータ管理
**親要素 parent**
 - ルール
     - `children_bloc`を持たない。
 - フィールド
    - key
 
**リスト状の子要素 children_bloc**
 - ルール
     - 親要素のkeyで呼び出せるようにする。
 
 
## Viewのフォルダ構成 について 
Htmlのように配置していく。  
関係が強い場合はファイル、弱い場合はフォルダ。

～編集中～

# ウィジェット
タイトル
- タイトルは基本AppBar(centerTitle: true)


戻るボタン(?)
- ユーザーが作成するページなどは(メモグループ、メモ)、「←arrow_back」
- 元からあるページなどは(作成ページ、設定ページ)、「×close」

