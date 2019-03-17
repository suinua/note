import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:note/models/memo.dart';

typedef OnMemoAdded(Memo addedMemo);
typedef OnMemoRemoved(Memo addedMemo);
typedef OnMemoChanged(Memo addedMemo);

class MemosRepository {
  final String parentGroupKey;
  DatabaseReference memosRef;

  final OnMemoAdded onMemoAdded;
  final OnMemoRemoved onMemoRemoved;
  final OnMemoChanged onMemoChanged;

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
      Map<String, dynamic> value =
          Map<String, dynamic>.from(event.snapshot.value);

      this.onMemoAdded(Memo.fromMap(event.snapshot.key, value));
    });
    memosRef.onChildRemoved.listen((event) {
      Map<String, dynamic> value =
          Map<String, dynamic>.from(event.snapshot.value);

      this.onMemoRemoved(Memo.fromMap(event.snapshot.key, value));
    });
    memosRef.onChildChanged.listen((event) {
      Map<String, dynamic> value =
          Map<String, dynamic>.from(event.snapshot.value);

      this.onMemoChanged(Memo.fromMap(event.snapshot.key, value));
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
