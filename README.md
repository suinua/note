# note
BLoCアーキテクチャとFirebaseでメモAPP

# 環境構築
Firebaseの準備（自分はFirebaseに付いて詳しくないので...）
https://firebase.google.com/docs/flutter/setup?hl=ja

# アーキテクチャ
データはblocで管理。

## Viewのフォルダ構成 について 
Htmlのように配置していく。  
関係が強い場合はファイル、弱い場合はフォルダ。

### リスト状

**logic**
Items Bloc ↔ Items Provider
Item Model

**view**
↓ `Items Bloc`
ItemList 
⇅ `onChanged,onRemoved`
Item Widget 
⇅ `Item`
Item Page 

### 入れ子状

**logic**
Parents Bloc ↔ Parents Provider
Parents Model
 - Children Bloc

Children Bloc ↔ Children Provider
Children Model


**view**
↓ `Parents Bloc`
ParentList 
⇅ `Parent,onChanged,onRemoved`
Parent Widget 
⇅ `Parent`
Parent Page 
↓ `Parent.Children Bloc`
Child List
⇅ `Child,onChanged,onRemoved`
Child Widget
⇅ `Child`
Child Page 

～編集中～ 

# ウィジェット
タイトル
- タイトルは基本AppBar(centerTitle: true)


戻るボタン(?)
- ユーザーが作成するページなどは(メモグループ、メモ)、「←arrow_back」
- 元からあるページなどは(作成ページ、設定ページ)、「×close」

