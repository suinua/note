# note
BLoCアーキテクチャとFirebaseでメモAPP

# 環境構築
Firebaseの準備（自分はFirebaseに付いて詳しくないので...）
https://firebase.google.com/docs/flutter/setup?hl=ja

# アーキテクチャ
データはblocで管理。

### 入れ子状のデータ管理
追加(addやcreateなど,,,)は親要素がやる。  
削除(removeやdeleteなど,,,)は直接子要素がやる。  
  
具体例  
```dart
class Parent {
  ChildrenBloc _childrenBloc;
  void addChild() {}
}
class ChildrenBloc {
  //...
}
class Child {
  void remove(){
    //TODO : どのように削除するべき？
    //１　Firebaseから直接削除
  }
  void update(){}
  //...
}
```

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

