import 'package:meta/meta.dart';
import 'package:note/models/memo_label.dart';

class Memo {
  final String key;

  String title;
  String body;

  Memo(
      {@required this.title,
      @required this.body,
      this.key});

  Memo.fromMap(this.key, Map<String, dynamic> memo) {
    this.title = memo['title'];
    this.body = memo['body'];
  }

  Map<String, dynamic> asMap() {
    return {
      'title': title,
      'body': body,
    };
  }

  @override
  bool operator ==(o) {
    return o is Memo && o.key == key;
  }
  
  @override
  int get hashCode => key.hashCode;
}
