import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:note/models/memo_group.dart';

typedef void OnTitleChanged(String title);
typedef void OnDescriptionChanged(String description);

class MemoGroupsRepository {
  DatabaseReference memoGroupTitleRef;
  DatabaseReference memoGroupDescriptionRef;

  final String groupKey;
  final OnTitleChanged onTitleChanged;
  final OnDescriptionChanged onDescriptionChanged;

  StreamSubscription<Event> _onTitleChangedListener;
  StreamSubscription<Event> _onDescriptionChangedListener;

  MemoGroupsRepository({
    @required this.groupKey,
    @required this.onTitleChanged,
    @required this.onDescriptionChanged,
  }) {
    memoGroupTitleRef = FirebaseDatabase.instance
        .reference()
        .child('memo_groups')
        .child(groupKey)
        .child('title');

    memoGroupDescriptionRef = FirebaseDatabase.instance
        .reference()
        .child('memo_groups')
        .child(groupKey)
        .child('description');

    _onTitleChangedListener = memoGroupTitleRef.onValue.listen((event) {
      onTitleChanged(event.snapshot.value);
    });
    _onDescriptionChangedListener =
        memoGroupDescriptionRef.onValue.listen((event) {
      onDescriptionChanged(event.snapshot.value);
    });
  }

  void updateGroup({String title, description}) {
    if (title != null) {
      memoGroupTitleRef.set(title);
    }
    if (description != null) {
      memoGroupDescriptionRef.set(description);
    }
  }

  void dispose() {
    _onTitleChangedListener.cancel();
    _onDescriptionChangedListener.cancel();
  }
}
