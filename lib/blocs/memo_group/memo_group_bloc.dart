import 'package:bloc_provider/bloc_provider.dart';
import 'package:note/models/memo_group.dart';

class MemoGroupBloc implements Bloc {
  //TODO : 値のやり取りをstream,sinkで

  MemoGroup _memoGroup;
  void setValue(MemoGroup memoGroup){
    _memoGroup = memoGroup;
    _memoGroup.setBlocs();
  }

  MemoGroup get value => _memoGroup;

  MemoGroupBloc();

  @override
  void dispose() {
    _memoGroup?.memosBloc?.dispose();
    _memoGroup?.templateMemoLabelsBloc?.dispose();
  }
}
