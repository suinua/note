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

  Stream<List<Memo>> get getAllMemos => _memosBloc.getAllMemos;

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
      //TODO :
      _memosBloc = MemosBloc(key);
    }
  }

  factory MemoGroup.fromMap(Map<String, dynamic> memoGroup) {
    List<Memo> memos = [];
    if (memoGroup['memos'] != null) {
      memoGroup['memos'].forEach((key, value) {
        value['key'] = key;
        Memo memo = Memo.fromMap((Map<String, dynamic>.from(value)));
        memos.add(memo);
      });
    }

    return MemoGroup(
      title: memoGroup['title'],
      description: memoGroup['description'],
      key: memoGroup['key'],
      memos: memos,
    );
  }

  Map<String, dynamic> asMap() {
    Map<String,dynamic> memos = {};
    _memos.forEach((memo){
      Map<String,dynamic> mapOfMemo = memo.asMap();
      mapOfMemo.remove('key');
      memos[memo.key] = mapOfMemo;
    });

    return {
      'title': title,
      'description': description,
      'memos': memos
    };
  }

  @override
  bool operator ==(o) {
    return o is MemoGroup && o.key == key;
  }
}
