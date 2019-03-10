import 'package:meta/meta.dart';
import 'package:note/models/memo_label.dart';

class Memo {
  final String parentKey;
  final String key;

  String title;
  String body;

  List<MemoLabel> _setLabels;

  void setLabel(MemoLabel label) {
    _setLabels.add(label);
  }

  void removeLabel(MemoLabel label) {
    _setLabels.remove(label);
  }

  Memo(
      {@required this.title,
      @required this.body,
      List<MemoLabel> labels = const <MemoLabel>[],
      this.key,
      this.parentKey})
      : _setLabels = labels;

  Memo.fromMap(this.parentKey, this.key, Map<String, dynamic> memo) {
    List<MemoLabel> labels = [];
    if (memo['memo_labels'] != null) {
      memo['memo_labels'].forEach((key, value) {
        value['key'] = key;
        MemoLabel label = MemoLabel.fromMap((Map<String, dynamic>.from(value)));
        labels.add(label);
      });
    }

    this.title = memo['title'];
    this.body = memo['body'];
    this._setLabels = labels;
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
