import 'package:meta/meta.dart';

class Memo {
  final String key;
  String title;
  String body;

  Memo({@required this.title, @required this.body, this.key});

  factory Memo.fromMap(Map<String, dynamic> memo) {
    return Memo(title: memo['title'], body: memo['body'], key: memo['key']);
  }

  Map<String, dynamic> asMap() => {
        'key':key,
        'title': title,
        'body': body,
      };

  @override
  bool operator ==(o) {
    return o is Memo && o.key == key;
  }
}
