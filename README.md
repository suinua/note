# note
BLoCアーキテクチャとFirebaseでメモAPP

# 環境構築
Firebaseの準備（自分はFirebaseに付いて詳しくないので...）
https://firebase.google.com/docs/flutter/setup?hl=ja

# アーキテクチャ
データはblocで管理。

入れ子状のblocは親要素が管理する。
ウィジェットから直接入れ子状のblocは操作はしない。
(曖昧...だってBLoCアーキテクチャ、ルール緩いじゃん...教えて偉い人...)

## ファイル構成
 - ページはフォルダで区切る
 例えば、メモグループページ
 
```
 page/
    memo_group/
        //ファイル名に「page」は入れない。
        //「widget」の場合はファイル名に入れる//ようにする。
        //クラス名には「page」「widget」を入れ//るようにする。
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

