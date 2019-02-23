import 'dart:async';

import 'package:note/firebase/memos_repository.dart';
import 'package:note/models/memo.dart';

class MemosBloc {
  final String parentGroupKey;
  MemosRepository _repository;
  List<Memo> _memos = <Memo>[];

  StreamController<List<Memo>> _memosController =
      StreamController<List<Memo>>();
  StreamController<Memo> _addMemoController = StreamController<Memo>();
  StreamController<Memo> _removeMemoController = StreamController<Memo>();
  StreamController<Memo> _updateMemoController = StreamController<Memo>();

  StreamSink<List<Memo>> get _setMemos => _memosController.sink;

  Stream<List<Memo>> get getAllMemos => _memosController.stream;

  StreamSink<Memo> get addMemo => _addMemoController.sink;

  StreamSink<Memo> get removeMemo => _removeMemoController.sink;

  StreamSink<Memo> get updateMemo => _updateMemoController.sink;

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
      _repository.addMemo(memo);
    });
    _removeMemoController.stream.listen((Memo memo) {
      _repository.removeMemo(memo);
    });
    _updateMemoController.stream.listen((Memo memo) {
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