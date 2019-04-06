import 'package:bloc_provider/bloc_provider.dart';
import 'package:note/models/memo.dart';

class MemoBloc implements Bloc {
  //TODO : 値のやり取りをstream,sinkで
  Memo _memo;

  void setValue(Memo memo) {
    _memo = memo;
    _memo.setBlocs();
  }

  Memo get value => _memo;

  MemoBloc();

  @override
  void dispose() {
    _memo?.disposeBlocs();
  }
}
