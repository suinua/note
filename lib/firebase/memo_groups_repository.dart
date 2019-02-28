import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:note/models/memo_group.dart';

class MemoGroupsRepository {
  DatabaseReference memoGroupsRef;
  final Function(MemoGroup) onGroupAdded;
  final Function(MemoGroup) onGroupRemoved;
  final Function(MemoGroup) onGroupChanged;

  MemoGroupsRepository(
      {@required this.onGroupAdded,
      @required this.onGroupRemoved,
      @required this.onGroupChanged}) {
    memoGroupsRef = FirebaseDatabase.instance.reference().child('memo_groups');

    memoGroupsRef.onChildAdded.listen((event) {
      Map<String, dynamic> value = Map<String, dynamic>.from(event.snapshot.value);
      value['key'] = event.snapshot.key;

      this.onGroupAdded(MemoGroup.fromMap(value));
    });
    memoGroupsRef.onChildRemoved.listen((event) {
      Map<String, dynamic> value = Map<String, dynamic>.from(event.snapshot.value);
      value['key'] = event.snapshot.key;

      this.onGroupRemoved(MemoGroup.fromMap(value));
    });
    memoGroupsRef.onChildChanged.listen((event) {
      Map<String, dynamic> value = Map<String, dynamic>.from(event.snapshot.value);
      value['key'] = event.snapshot.key;

      this.onGroupChanged(MemoGroup.fromMap(value));
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
