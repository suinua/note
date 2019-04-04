import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:note/models/memo_group.dart';

typedef void OnMemoGroupAdded(MemoGroup addedMemo);
typedef void OnMemoGroupRemoved(MemoGroup addedMemo);
typedef void OnMemoGroupChanged(MemoGroup addedMemo);

class MemoGroupsRepository {
  DatabaseReference memoGroupsRef;

  final OnMemoGroupAdded onGroupAdded;
  final OnMemoGroupRemoved onGroupRemoved;
  final OnMemoGroupChanged onGroupChanged;

  StreamSubscription<Event> _onChildAddedListener;
  StreamSubscription<Event> _onChildRemovedListener;
  StreamSubscription<Event> _onChildChangedListener;

  MemoGroupsRepository(
      {@required this.onGroupAdded,
      @required this.onGroupRemoved,
      @required this.onGroupChanged}) {
    memoGroupsRef = FirebaseDatabase.instance.reference().child('memo_groups');

    _onChildAddedListener = memoGroupsRef.onChildAdded.listen((event) {
      Map<String, dynamic> value =
          Map<String, dynamic>.from(event.snapshot.value);

      this.onGroupAdded(MemoGroup.fromMap(event.snapshot.key, value));
    });
    _onChildRemovedListener = memoGroupsRef.onChildRemoved.listen((event) {
      Map<String, dynamic> value =
          Map<String, dynamic>.from(event.snapshot.value);

      this.onGroupRemoved(MemoGroup.fromMap(event.snapshot.key, value));
    });
    _onChildChangedListener = memoGroupsRef.onChildChanged.listen((event) {
      Map<String, dynamic> value =
          Map<String, dynamic>.from(event.snapshot.value);

      this.onGroupChanged(MemoGroup.fromMap(event.snapshot.key, value));
    });
  }

  void addGroup(MemoGroup memoGroup) {
    memoGroupsRef.push().set(memoGroup.asMap());
  }

  void removeGroup(MemoGroup memoGroup) {
    memoGroupsRef.child(memoGroup.key).remove();
  }

  void updateGroup(MemoGroup memoGroup) {
    memoGroupsRef.child(memoGroup.key).update(memoGroup.asMap());
  }

  void dispose() {
    _onChildAddedListener.cancel();
    _onChildRemovedListener.cancel();
    _onChildChangedListener.cancel();
  }
}
