import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:note/models/memo.dart';

typedef void OnMemoAdded(Memo addedMemo);
typedef void OnMemoRemoved(Memo addedMemo);
typedef void OnMemoChanged(Memo addedMemo);

class MemosRepository {
  final String parentGroupKey;
  DatabaseReference memosRef;

  final OnMemoAdded onMemoAdded;
  final OnMemoRemoved onMemoRemoved;
  final OnMemoChanged onMemoChanged;

  StreamSubscription<Event> _onChildAddedListener;
  StreamSubscription<Event> _onChildRemovedListener;
  StreamSubscription<Event> _onChildChangedListener;

  MemosRepository(this.parentGroupKey,
      {@required this.onMemoAdded,
      @required this.onMemoRemoved,
      @required this.onMemoChanged}) {
    memosRef = FirebaseDatabase.instance
        .reference()
        .child('memo_groups')
        .child(parentGroupKey)
        .child('memos');

    _onChildAddedListener = memosRef.onChildAdded.listen((event) {
      Map<String, dynamic> value =
          Map<String, dynamic>.from(event.snapshot.value);

      this.onMemoAdded(Memo.fromMap(parentGroupKey, event.snapshot.key, value));
    });
    _onChildRemovedListener = memosRef.onChildRemoved.listen((event) {
      Map<String, dynamic> value =
          Map<String, dynamic>.from(event.snapshot.value);

      this.onMemoRemoved(
          Memo.fromMap(parentGroupKey, event.snapshot.key, value));
    });
    _onChildChangedListener = memosRef.onChildChanged.listen((event) {
      Map<String, dynamic> value =
          Map<String, dynamic>.from(event.snapshot.value);

      this.onMemoChanged(
          Memo.fromMap(parentGroupKey, event.snapshot.key, value));
    });
  }

  void addMemo(Memo memo) {
    memosRef.push().set(memo.asMap());
  }

  void removeMemo(Memo memo) {
    memosRef.child(memo.key).remove();
  }

  void updateMemo(Memo memo) {
    memosRef.child(memo.key).update(memo.asMap());
  }

  void dispose() {
    _onChildAddedListener.cancel();
    _onChildRemovedListener.cancel();
    _onChildChangedListener.cancel();
  }
}
