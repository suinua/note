import 'package:meta/meta.dart';
import 'package:note/blocs/memos_bloc.dart';
import 'package:note/models/memo.dart';

//memo groupはmemosBlocを通じてmemosを管理してる。
class MemoGroup {
  final String key;
  String title;
  String description;

  MemosBloc _memosBloc;
  List<Memo> _memos;

  List<Memo> get getAllMemos => _memos;

  void addMemo(Memo memo) {
    _memosBloc.addMemo.add(memo);
  }

  void removeMemo(Memo memo) {
    _memosBloc.removeMemo.add(memo);
  }

  void updateMemo(Memo memo) {
    _memosBloc.updateMemo.add(memo);
  }

  MemoGroup(
      {@required this.title,
      @required this.description,
      this.key,
      List<Memo> memos = const <Memo>[]}) {
    _memos = memos;
    if (key != null) {
      _memosBloc = MemosBloc(key);
      _memosBloc.getAllMemos.listen((event) {
        _memos = event;
      });
      _memosBloc.getAllMemos.listen((allMemos) {
        _memos = allMemos;
      });
    }
  }

  factory MemoGroup.fromMap(Map<String, dynamic> memoGroup) {
    return MemoGroup(
      title: memoGroup['title'],
      description: memoGroup['description'],
      key: memoGroup['key'],
      memos: memoGroup['memos'] == null
          ? []
          : memoGroup['memos'].map((memo) => Memo.fromMap(memo)).toList(),
    );
  }

  Map<String, dynamic> asMap() => {
        'title': title,
        'description': description,
        'memos': _memos.map((memo) => memo.asMap()).toList(),
      };

  @override
  bool operator ==(o) {
    return o is MemoGroup && o.key == key;
  }
}
