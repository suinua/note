import 'package:meta/meta.dart';
import 'package:note/blocs/memo/memo_labels_bloc.dart';

class Memo {
  final String parentGroupKey;
  final String key;

  String title;
  String body;

  MemoLabelsBloc _labelsBLoc;

  MemoLabelsBloc get labelsBloc => _labelsBLoc;

  void disposeBlocs(){
    _labelsBLoc?.dispose();
  }

  void setBlocs() {
    _labelsBLoc = MemoLabelsBloc(parentGroupKey, key);
  }

  Memo(
      {@required this.title,
      @required this.body,
      this.parentGroupKey,
      this.key});

  Memo.fromMap(this.parentGroupKey, this.key, Map<String, dynamic> memo) {
    assert(key != null || parentGroupKey != null);

    this.title = memo['title'];
    this.body = memo['body'];

    _labelsBLoc = MemoLabelsBloc(parentGroupKey, key);
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
