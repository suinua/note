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