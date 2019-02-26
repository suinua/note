import 'package:note/firebase/memos_repository.dart';
import 'package:note/models/memo.dart';
import 'package:rxdart/rxdart.dart';

class MemosBloc {
  final String parentGroupKey;
  MemosRepository _repository;
  List<Memo> _memos = <Memo>[];

  BehaviorSubject<List<Memo>> _memosController = BehaviorSubject<List<Memo>>();
  BehaviorSubject<Memo> _addMemoController = BehaviorSubject<Memo>();
  BehaviorSubject<Memo> _removeMemoController = BehaviorSubject<Memo>();
  BehaviorSubject<Memo> _updateMemoController = BehaviorSubject<Memo>();

  Sink<List<Memo>> get _setMemos => _memosController.sink;

  Stream<List<Memo>> get getAllMemos => _memosController.stream;

  Sink<Memo> get addMemo => _addMemoController.sink;

  Sink<Memo> get removeMemo => _removeMemoController.sink;

  Sink<Memo> get updateMemo => _updateMemoController.sink;

  MemosBloc(this.parentGroupKey) {
    void _onAdded(Memo addedMemo) {
      _memos.add(addedMemo);
      _setMemos.add(_memos);
    }

    void _onRemoved(Memo removedMemo) {
      _memos.remove(removedMemo);
      _setMemos.add(_memos);
    }

    void _onChanged(Memo changedMemo) {
      _memos.forEach((Memo memo) {
        if (memo == changedMemo) {
          memo = changedMemo;
        }
      });
      _setMemos.add(_memos);
    }

    _repository = MemosRepository(parentGroupKey,
        onMemoAdded: _onAdded,
        onMemoRemoved: _onRemoved,
        onMemoChanged: _onChanged);

    _addMemoController.stream.listen((Memo memo) {
      print('add memo : ${memo.asMap()}');
      _repository.addMemo(memo);
    });
    _removeMemoController.stream.listen((Memo memo) {
      print('remove memo : ${memo.asMap()}');
      _repository.removeMemo(memo);
    });
    _updateMemoController.stream.listen((Memo memo) {
      print('update memo : ${memo.asMap()}');
      _repository.updateMemo(memo);
    });
  }

  void dispose() async {
    await _memosController.close();
    await _addMemoController.close();
    await _removeMemoController.close();
    await _updateMemoController.close();
  }
}
