import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:note/models/memo_group.dart';

typedef OnMemoGroupAdded(MemoGroup addedMemo);
typedef OnMemoGroupRemoved(MemoGroup addedMemo);
typedef OnMemoGroupChanged(MemoGroup addedMemo);

class MemoGroupsRepository {
  DatabaseReference memoGroupsRef;
  final OnMemoGroupAdded onGroupAdded;
  final OnMemoGroupRemoved onGroupRemoved;
  final OnMemoGroupChanged onGroupChanged;

  MemoGroupsRepository(
      {@required this.onGroupAdded,
      @required this.onGroupRemoved,
      @required this.onGroupChanged}) {
    memoGroupsRef = FirebaseDatabase.instance.reference().child('memo_groups');

    memoGroupsRef.onChildAdded.listen((event) {
      Map<String, dynamic> value = Map<String, dynamic>.from(event.snapshot.value);

      this.onGroupAdded(MemoGroup.fromMap(event.snapshot.key,value));
    });
    memoGroupsRef.onChildRemoved.listen((event) {
      Map<String, dynamic> value = Map<String, dynamic>.from(event.snapshot.value);

      this.onGroupRemoved(MemoGroup.fromMap(event.snapshot.key,value));
    });
    memoGroupsRef.onChildChanged.listen((event) {
      Map<String, dynamic> value = Map<String, dynamic>.from(event.snapshot.value);

      this.onGroupChanged(MemoGroup.fromMap(event.snapshot.key,value));
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
}
