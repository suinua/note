import 'package:meta/meta.dart';
import 'package:note/models/label.dart';

class Memo {
  final String key;
  String title;
  String body;
  List<Label> _setLabels;

  void setLabel(Label label) {
    _setLabels.add(label);
  }

  void removeLabel(Label label) {
    _setLabels.remove(label);
  }

  Memo(
      {@required this.title,
      @required this.body,
      List<Label> labels = const <Label>[],
      this.key})
      : _setLabels = labels;

  factory Memo.fromMap(Map<String, dynamic> memo) {
    List<Label> labels = [];
    if (memo['memo_labels'] != null) {
      memo['memo_labels'].forEach((key, value) {
        value['key'] = key;
        Label label = Label.fromMap((Map<String, dynamic>.from(value)));
        labels.add(label);
      });
    }

    return Memo(
      key: memo['key'],
      title: memo['title'],
      body: memo['body'],
      labels: labels,
    );
  }

  Map<String, dynamic> asMap() {
    Map<String, dynamic> labels = {};
    _setLabels.forEach((label) {
      Map<String, dynamic> mapOfMemo = label.asMap();
      mapOfMemo.remove('key');
      labels[label.key] = mapOfMemo;
    });

    return {
      'key': key,
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
