import 'package:note/models/memo_group.dart';

class MemoGroupContainer {
  MemoGroup _memoGroup;
  void setValue(MemoGroup memoGroup) => _memoGroup = memoGroup;
  MemoGroup get value => _memoGroup;

  MemoGroupContainer();
}
