import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:note/models/memo.dart';

class MemosRepository {
  final String parentGroupKey;
  DatabaseReference memosRef;
  final Function(Memo) onMemoAdded;
  final Function(Memo) onMemoRemoved;
  final Function(Memo) onMemoChanged;

  MemosRepository(this.parentGroupKey,
      {@required this.onMemoAdded,
      @required this.onMemoRemoved,
      @required this.onMemoChanged}) {
    memosRef = FirebaseDatabase.instance
        .reference()
        .child('memo_groups')
        .child(parentGroupKey)
        .child('memos');

    memosRef.onChildAdded.listen((event) {
      Map<String, dynamic> value = event.snapshot.value;
      value['key'] = event.snapshot.key;

      this.onMemoAdded(Memo.fromMap(value));
    });
    memosRef.onChildRemoved.listen((event) {
      Map<String, dynamic> value = event.snapshot.value;
      value['key'] = event.snapshot.key;

      this.onMemoRemoved(Memo.fromMap(value));
    });
    memosRef.onChildAdded.listen((event) {
      Map<String, dynamic> value = event.snapshot.value;
      value['key'] = event.snapshot.key;

      this.onMemoChanged(Memo.fromMap(value));
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
}