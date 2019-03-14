import 'package:meta/meta.dart';
import 'package:note/blocs/memo_labels_bloc.dart';
import 'package:note/blocs/memos_bloc.dart';
import 'package:note/models/memo_label.dart';
import 'package:note/models/memo.dart';

//memo groupはmemosBlocを通じてmemosを管理してる。
class MemoGroup {
  final String key;
  String title;
  String description;

  MemosBloc _memosBloc;
  MemoLabelsBloc _labelsBloc;

  Stream<List<Memo>> get getAllMemos => _memosBloc.getAllMemos;

  Stream<List<MemoLabel>> get getAllMemoLabels => _labelsBloc.getAllLabels;

  MemoGroup({@required this.title, @required this.description, this.key}) {
    if (key != null) {
      //TODO :
      _memosBloc = MemosBloc(key);
      _labelsBloc = MemoLabelsBloc(key);
    }
  }

  MemoGroup.fromMap(this.key, Map<String, dynamic> memoGroup) {
    this._memosBloc = MemosBloc(key);
    this._labelsBloc = MemoLabelsBloc(key);

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
}
