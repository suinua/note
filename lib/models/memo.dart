import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:note/models/memo_label.dart';

class Memo {
  final String parentKey;
  final String key;
  DatabaseReference _memoRef;

  String _title;
  String _body;

  String get title => _title;

  String get body => _body;
  List<MemoLabel> _setLabels;

  //TODO : blocを通さずにfirebaseを操作している

  void remove() {
    _memoRef.remove();
  }

  void updateTitle(String value) {
    _title = value;
    _memoRef.update(asMap());
  }

  void updateBody(String value) {
    _body = value;
    _memoRef.update(asMap());
  }

  void setLabel(MemoLabel label) {
    _setLabels.add(label);
  }

  void removeLabel(MemoLabel label) {
    _setLabels.remove(label);
  }

  Memo(
      {@required title,
      @required body,
      List<MemoLabel> labels = const <MemoLabel>[],
      this.key,
      this.parentKey})
      : _title = title,
        _body = body,
        _setLabels = labels,
        _memoRef = key == null
            ? null
            : FirebaseDatabase.instance
                .reference()
                .child('memo_groups')
                .child(parentKey)
                .child('memos')
                .child(key);

  Memo.fromMap(this.parentKey, this.key, Map<String, dynamic> memo) {
    List<MemoLabel> labels = [];
    if (memo['memo_labels'] != null) {
      memo['memo_labels'].forEach((key, value) {
        value['key'] = key;
        MemoLabel label = MemoLabel.fromMap((Map<String, dynamic>.from(value)));
        labels.add(label);
      });
    }

    this._title = memo['title'];
    this._body = memo['body'];
    this._setLabels = labels;
    this._memoRef = key == null
        ? null
        : FirebaseDatabase.instance
            .reference()
            .child('memo_groups')
            .child(parentKey)
            .child('memos')
            .child(key);
  }

  Map<String, dynamic> asMap() {
    Map<String, dynamic> labels = {};
    _setLabels?.forEach((label) {
      Map<String, dynamic> mapOfMemo = label.asMap();
      mapOfMemo.remove('key');
      labels[label.key] = mapOfMemo;
    });

    return {
      'title': title,
      'body': body,
      'set_labels': labels,
    };
  }

  @override
  bool operator ==(o) {
    return o is Memo && o.key == key;
  }
}
