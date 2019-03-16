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
 
 
## ファイル構成
 - ページはフォルダで区切る
 例えば、メモグループページ
 
```
 page/
    memo_group/
        //ファイル名に「page」は入れない。
        //「widget」の場合はファイル名に入れるようにする。
        //クラス名には「page」「widget」を入れるようにする。
        main.dart
        setting.dart
        create_memo.dart
 ```
 
 - modelようのウィジェット
 ```
 model_widgets/
    //ファイル名に「widget」は入れない。
    //クラス名にはつける。
    memo_group.dart
 ```

# ウィジェット
タイトル
- タイトルは基本AppBar(centerTitle: true)


戻るボタン(?)
- ユーザーが作成するページなどは(メモグループ、メモ)、「←arrow_back」
- 元からあるページなどは(作成ページ、設定ページ)、「×close」

