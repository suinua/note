import 'package:meta/meta.dart';

class MemoGroup {
  final String key;
  String title;
  String description;

  MemoGroup({@required this.title, @required this.description, this.key});

  MemoGroup.fromMap(this.key, Map<String, dynamic> memoGroup) {
    this.title = memoGroup['title'];
    this.description = memoGroup['description'];
  }

  Map<String, dynamic> asMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  @override
  bool operator ==(o) {
    return o is MemoGroup && o.key == key;
  }

  @override
  int get hashCode => key.hashCode;
}
