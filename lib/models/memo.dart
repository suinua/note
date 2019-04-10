import 'package:meta/meta.dart';
import 'package:note/blocs/memo/memo_labels_bloc.dart';
import 'package:note/models/memo_label.dart';

class Memo {
  final String parentGroupKey;
  final String key;

  String title;
  String body;

  _MemoChildren _memoChildren;

  _MemoChildren get children => _memoChildren;

  Memo(
      {@required this.title,
      @required this.body,
      this.parentGroupKey,
      this.key}) {
    if (key != null) {
      _memoChildren = _MemoChildren(parentGroupKey,key);
    }
  }

  Memo.fromMap(this.parentGroupKey, this.key, Map<String, dynamic> memo) {
    assert(key != null || parentGroupKey != null);

    this.title = memo['title'];
    this.body = memo['body'];
    this._memoChildren = _MemoChildren(parentGroupKey,key);
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

class _MemoChildren {
  _IncrementMemoLabels _incrementMemoLabels;

  _IncrementMemoLabels get incrementMemoLabels => _incrementMemoLabels;

  List<MemoLabel> get memoLabels => _incrementMemoLabels._memoLabels;

  _MemoChildren(String groupKey, memoKey) {
    _incrementMemoLabels = _IncrementMemoLabels(groupKey, memoKey);
  }
}

abstract class _IncrementChildren<E> {
  void add(E child) {}

  void delete(E child) {}

  void update(E child) {}
}

class _IncrementMemoLabels implements _IncrementChildren<MemoLabel> {
  final String groupKey;
  final String memoKey;
  MemoLabelsBloc _memoLabelsBloc;
  List<MemoLabel> _memoLabels;

  _IncrementMemoLabels(this.groupKey, this.memoKey) {
    _memoLabels = <MemoLabel>[];
    _memoLabelsBloc = MemoLabelsBloc(groupKey, memoKey);
    _memoLabelsBloc.getAllLabels.listen((labels) => _memoLabels = labels);
  }

  void add(MemoLabel child) {
    _memoLabelsBloc.addLabel.add(child);
  }

  @override
  void delete(MemoLabel child) {
    _memoLabelsBloc.removeLabel.add(child);
  }

  @override
  void update(MemoLabel child) {
    _memoLabelsBloc.updateLabel.add(child);
  }
}
