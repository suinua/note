import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:note/models/memo_label.dart';

class MemoLabelsRepository {
  final String parentGroupKey;
  DatabaseReference labelsRef;
  final Function(MemoLabel) onLabelAdded;
  final Function(MemoLabel) onLabelRemoved;
  final Function(MemoLabel) onLabelChanged;

  MemoLabelsRepository(this.parentGroupKey,
      {@required this.onLabelAdded,
        @required this.onLabelRemoved,
        @required this.onLabelChanged}) {
    labelsRef = FirebaseDatabase.instance
        .reference()
        .child('memo_groups')
        .child(parentGroupKey)
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
