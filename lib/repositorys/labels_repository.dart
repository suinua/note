import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:note/models/label.dart';

class LabelsRepository {
  final String parentGroupKey;
  DatabaseReference labelsRef;
  final Function(Label) onLabelAdded;
  final Function(Label) onLabelRemoved;
  final Function(Label) onLabelChanged;

  LabelsRepository(this.parentGroupKey,
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

      this.onLabelAdded(Label.fromMap(value));
    });
    labelsRef.onChildRemoved.listen((event) {
      Map<String, dynamic> value =
      Map<String, dynamic>.from(event.snapshot.value);
      value['key'] = event.snapshot.key;

      this.onLabelRemoved(Label.fromMap(value));
    });
    labelsRef.onChildChanged.listen((event) {
      Map<String, dynamic> value =
      Map<String, dynamic>.from(event.snapshot.value);
      value['key'] = event.snapshot.key;

      this.onLabelChanged(Label.fromMap(value));
    });
  }

  void addLabel(Label memo) {
    labelsRef.push().set(memo.asMap());
  }

  void removeLabel(Label memo) {
    labelsRef.child(memo.key).remove();
  }

  void updateLabel(Label memo) {
    labelsRef.child(memo.key).update(memo.asMap());
  }
}
