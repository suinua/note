import 'package:meta/meta.dart';
import 'package:note/blocs/memo_group/template_memo_labels_bloc.dart';

class MemoGroup {
  final String key;
  String title;
  String description;

  TemplateMemoLabelsBloc _templateMemoLabelsBloc;

  TemplateMemoLabelsBloc get templateMemoLabelsBloc => _templateMemoLabelsBloc;


  void disposeBlocs() {
    _templateMemoLabelsBloc?.dispose();
  }

  void setBlocs() {
    _templateMemoLabelsBloc = TemplateMemoLabelsBloc(key);
  }

  MemoGroup(
      {@required this.title,
      @required this.description,
      templateLabels,
      this.key});

  MemoGroup.fromMap(this.key, Map<String, dynamic> memoGroup) {
    assert(key != null);

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
