import 'package:note/models/memo.dart';

class MemoGroup {
  final String key;
  String title;
  String description;
  List<Memo> memos;

  MemoGroup(this.title, this.description, {this.key, this.memos});

  factory MemoGroup.fromMap(Map<String, dynamic> memoGroup) {
    return MemoGroup(
      memoGroup['title'],
      memoGroup['description'],
      key: memoGroup['key'],
      memos: memoGroup['memos'].map((memo) => Memo.fromMap(memo)).toList(),
    );
  }

  Map<String, dynamic> asMap() => {
        'title': title,
        'description': description,
        'memos': memos.map((memo) => memo.asMap()).toList(),
      };

  @override
  bool operator ==(o) {
    return o is MemoGroup && key == key;
  }
}
