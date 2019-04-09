import 'package:bloc_provider/bloc_provider.dart';
import 'package:note/log.dart';
import 'package:note/repositories/memos_repository.dart';
import 'package:note/models/memo.dart';
import 'package:rxdart/rxdart.dart';

class MemosBloc extends Bloc {
  MemosBloc();

  String parentGroupKey;
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

  void _onAdded(Memo addedMemo) {
    _memos.add(addedMemo);
    _setMemos.add(_memos);

    Log.memo.onAddedOnFirebase(addedMemo.asMap());
  }

  void _onRemoved(Memo removedMemo) {
    _memos.remove(removedMemo);
    _setMemos.add(_memos);

    Log.memo.onRemovedOnFirebase(removedMemo.asMap());
  }

  void _onChanged(Memo changedMemo) {
    _memos.forEach((Memo memo) {
      if (memo == changedMemo) {
        memo = changedMemo;

        _setMemos.add(_memos);

        Log.memo.onUpdatedOnFirebase(changedMemo.asMap());
      }
    });
  }

  void _setListener() {
    _addMemoController.stream.listen((Memo memo) {
      _repository.addMemo(memo);
      Log.memo.onAdded(memo.asMap());
    });
    _removeMemoController.stream.listen((Memo memo) {
      _repository.removeMemo(memo);
      Log.memo.onRemoved(memo.asMap());
    });
    _updateMemoController.stream.listen((Memo memo) {
      _repository.updateMemo(memo);
      Log.memo.onUpdated(memo.asMap());
    });
  }

  void reset(String parentGroupKey) {
    this.dispose();
    _memosController = BehaviorSubject<List<Memo>>();
    _addMemoController = BehaviorSubject<Memo>();
    _removeMemoController = BehaviorSubject<Memo>();
    _updateMemoController = BehaviorSubject<Memo>();
    _repository = MemosRepository(
      parentGroupKey,
      onMemoAdded: _onAdded,
      onMemoRemoved: _onRemoved,
      onMemoChanged: _onChanged,
    );

    _setListener();
  }

  void dispose() async {
    _memos = <Memo>[];
    _repository?.dispose();
    /*
    なぜdrain？わからん。
    https://stackoverflow.com/questions/52191451/bad-state-you-cannot-close-the-subject-while-items-are-being-added-from-addstre/52191587
     */
    await _memosController.drain();
    await _addMemoController.drain();
    await _removeMemoController.drain();
    await _updateMemoController.drain();

    await _memosController.close();
    await _addMemoController.close();
    await _removeMemoController.close();
    await _updateMemoController.close();
  }
}
