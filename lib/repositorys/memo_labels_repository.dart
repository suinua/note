import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:note/models/memo_label.dart';

typedef void OnMemoLabelAdded(MemoLabel addedMemo);
typedef void OnMemoLabelRemoved(MemoLabel addedMemo);
typedef void OnMemoLabelChanged(MemoLabel addedMemo);

class MemoLabelsRepository {
  final String parentGroupKey;
  final String ownerMemoKey;
  DatabaseReference labelsRef;
  final OnMemoLabelAdded onLabelAdded;
  final OnMemoLabelRemoved onLabelRemoved;
  final OnMemoLabelChanged onLabelChanged;

  MemoLabelsRepository(this.parentGroupKey, this.ownerMemoKey,
      {@required this.onLabelAdded,
      @required this.onLabelRemoved,
      @required this.onLabelChanged}) {
    labelsRef = FirebaseDatabase.instance
        .reference()
        .child('memo_groups')
        .child(parentGroupKey)
        .child(ownerMemoKey)
        .child('memo_labels');

    labelsRef.onChildAdded.listen((event) {
      Map<String, dynamic> value =
          Map<String, dynamic>.from(event.snapshot.value);
      value['key'] = event.snapshot.key;

      this.onLabelAdded(MemoLabel.fromMap(value));
    });
    labelsRef.onChildRemoved.listen((event) {
      Map<String, dynamic> value =
          Map<String, dynamic>.from(event.snapshot.value);
      value['key'] = event.snapshot.key;

      this.onLabelRemoved(MemoLabel.fromMap(value));
    });
    labelsRef.onChildChanged.listen((event) {
      Map<String, dynamic> value =
          Map<String, dynamic>.from(event.snapshot.value);
      value['key'] = event.snapshot.key;

      this.onLabelChanged(MemoLabel.fromMap(value));
    });
  }

  void addLabel(MemoLabel memo) {
    labelsRef.push().set(memo.asMap());
  }

  void removeLabel(MemoLabel memo) {
    labelsRef.child(memo.key).remove();
  }

  void updateLabel(MemoLabel memo) {
    labelsRef.child(memo.key).update(memo.asMap());
  }
}
