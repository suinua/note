import 'package:note/models/memo.dart';

class MemoBloc {
  Memo _memo;
  void setValue(Memo memo) => _memo = memo;
  Memo get value => _memo;

  MemoBloc();
}
