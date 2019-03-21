import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:note/models/template_memo_label.dart';

typedef void OnMemoLabelAdded(TemplateMemoLabel addedMemo);
typedef void OnMemoLabelRemoved(TemplateMemoLabel addedMemo);
typedef void OnMemoLabelChanged(TemplateMemoLabel addedMemo);

class TemplateMemoLabelsRepository {
  final String parentGroupKey;
  DatabaseReference labelsRef;
  final OnMemoLabelAdded onLabelAdded;
  final OnMemoLabelRemoved onLabelRemoved;
  final OnMemoLabelChanged onLabelChanged;

  TemplateMemoLabelsRepository(this.parentGroupKey,
      {@required this.onLabelAdded,
      @required this.onLabelRemoved,
      @required this.onLabelChanged}) {
    labelsRef = FirebaseDatabase.instance
        .reference()
        .child('memo_groups')
        .child(parentGroupKey)
        .child('template_labels');

    labelsRef.onChildAdded.listen((event) {
      Map<String, dynamic> value =
          Map<String, dynamic>.from(event.snapshot.value);

      this.onLabelAdded(TemplateMemoLabel.fromMap(event.snapshot.key,value));
    });
    labelsRef.onChildRemoved.listen((event) {
      Map<String, dynamic> value =
          Map<String, dynamic>.from(event.snapshot.value);

      this.onLabelRemoved(TemplateMemoLabel.fromMap(event.snapshot.key,value));
    });
    labelsRef.onChildChanged.listen((event) {
      Map<String, dynamic> value =
          Map<String, dynamic>.from(event.snapshot.value);

      this.onLabelChanged(TemplateMemoLabel.fromMap(event.snapshot.key,value));
    });
  }

  void addLabel(TemplateMemoLabel memo) {
    labelsRef.push().set(memo.asMap());
  }

  void removeLabel(TemplateMemoLabel memo) {
    labelsRef.child(memo.key).remove();
  }

  void updateLabel(TemplateMemoLabel memo) {
    labelsRef.child(memo.key).update(memo.asMap());
  }
}
