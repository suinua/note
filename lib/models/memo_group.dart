import 'package:meta/meta.dart';
import 'package:note/blocs/memo/memos_bloc.dart';
import 'package:note/blocs/memo_group/template_memo_labels_bloc.dart';
import 'package:note/models/memo.dart';
import 'package:note/models/template_memo_label.dart';

class MemoGroup {
  final String key;
  String title;
  String description;
  _MemoGroupChildren _memoGroupChildren;

  _MemoGroupChildren get children => _memoGroupChildren;

  MemoGroup({@required this.title, @required this.description, this.key}) {
    if (key != null) {
      _memoGroupChildren = _MemoGroupChildren(key);
    }
  }

  MemoGroup.fromMap(this.key, Map<String, dynamic> memoGroup) {
    assert(key != null);

    this.title = memoGroup['title'];
    this.description = memoGroup['description'];
    this._memoGroupChildren = _MemoGroupChildren(key);
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

class _MemoGroupChildren {
  final String groupKey;

  _IncrementMemos _incrementMemos;
  _IncrementTemplateMemoLabels _incrementTemplateMemoLabels;

  _IncrementMemos get incrementMemos => _incrementMemos;

  _IncrementTemplateMemoLabels get incrementTemplateMemoLabels =>
      _incrementTemplateMemoLabels;

  List<Memo> get memos => _incrementMemos._memos;

  List<TemplateMemoLabel> get templateMemoLabels =>
      _incrementTemplateMemoLabels._templateMemoLabels;

  _MemoGroupChildren(this.groupKey) {
    _incrementMemos = _IncrementMemos(groupKey);
    _incrementTemplateMemoLabels = _IncrementTemplateMemoLabels(groupKey);
  }
}

abstract class _IncrementChildren<E> {
  void add(E child) {}

  void delete(E child) {}

  void update(E child) {}
}

class _IncrementMemos implements _IncrementChildren<Memo> {
  final String groupKey;
  MemosBloc _memosBloc;
  List<Memo> _memos;

  _IncrementMemos(this.groupKey) {
    _memos = <Memo>[];
    _memosBloc = MemosBloc(groupKey);
    _memosBloc.getAllMemos.listen((memos) => _memos = memos);
  }

  @override
  void add(Memo child) {
    _memosBloc.addMemo.add(child);
  }

  @override
  void delete(Memo child) {
    _memosBloc.removeMemo.add(child);
  }

  @override
  void update(Memo child) {
    _memosBloc.updateMemo.add(child);
  }
}

class _IncrementTemplateMemoLabels
    implements _IncrementChildren<TemplateMemoLabel> {
  final String groupKey;
  TemplateMemoLabelsBloc _templateMemoLabelsBloc;
  List<TemplateMemoLabel> _templateMemoLabels;

  _IncrementTemplateMemoLabels(this.groupKey) {
    _templateMemoLabels = <TemplateMemoLabel>[];
    _templateMemoLabelsBloc = TemplateMemoLabelsBloc(groupKey);
    _templateMemoLabelsBloc.getAllLabels
        .listen((labels) => _templateMemoLabels = labels);
  }

  @override
  void add(TemplateMemoLabel child) {
    _templateMemoLabelsBloc.addLabel.add(child);
  }

  @override
  void delete(TemplateMemoLabel child) {
    _templateMemoLabelsBloc.removeLabel.add(child);
  }

  @override
  void update(TemplateMemoLabel child) {
    _templateMemoLabelsBloc.updateLabel.add(child);
  }
}
