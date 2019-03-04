import 'package:meta/meta.dart';
import 'package:note/blocs/memos_bloc.dart';
import 'package:note/models/label.dart';
import 'package:note/models/memo.dart';

//memo groupはmemosBlocを通じてmemosを管理してる。
class MemoGroup {
  final String key;
  String title;
  String description;

  MemosBloc _memosBloc;
  List<Memo> _memos;
  List<Label> _memoLabels;

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

  void addMemoLabel(Memo memo) {
    //TODO : addLabel
  }

  void removeMemoLabel(Memo memo) {
    //TODO : removeLabel
  }

  void updateMemoLabel(Memo memo) {
    //TODO : updateLabel
  }

  MemoGroup(
      {@required this.title,
      @required this.description,
      this.key,
      List<Memo> memos = const <Memo>[],
      List<Label> labels = const <Label>[]}) {
    _memos = memos;
    _memoLabels = labels;
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

    List<Label> labels = [];
    if (memoGroup['memo_labels'] != null) {
      memoGroup['memo_labels'].forEach((key, value) {
        value['key'] = key;
        Label label = Label.fromMap((Map<String, dynamic>.from(value)));
        labels.add(label);
      });
    }

    return MemoGroup(
      title: memoGroup['title'],
      description: memoGroup['description'],
      key: memoGroup['key'],
      memos: memos,
      labels: labels,
    );
  }

  Map<String, dynamic> asMap() {
    Map<String, dynamic> memos = {};
    _memos.forEach((memo) {
      Map<String, dynamic> mapOfMemo = memo.asMap();
      mapOfMemo.remove('key');
      memos[memo.key] = mapOfMemo;
    });

    Map<String, dynamic> labels = {};
    _memoLabels.forEach((label) {
      Map<String, dynamic> mapOfLabel = label.asMap();
      mapOfLabel.remove('key');
      labels[label.key] = mapOfLabel;
    });

    return {
      'title': title,
      'description': description,
      'memos': memos,
      'memo_labels': labels,
    };
  }

  @override
  bool operator ==(o) {
    return o is MemoGroup && o.key == key;
  }
}
