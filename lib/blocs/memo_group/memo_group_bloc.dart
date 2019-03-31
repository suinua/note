import 'package:note/models/memo_group.dart';

class MemoGroupBloc {
  MemoGroup _memoGroup;
  void setValue(MemoGroup memoGroup) => _memoGroup = memoGroup;
  MemoGroup get value => _memoGroup;

  MemoGroupBloc();
}
