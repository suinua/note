import 'package:bloc_provider/bloc_provider.dart';
import 'package:note/log.dart';
import 'package:note/repositories/memo_groups_repository.dart';
import 'package:note/models/memo_group.dart';
import 'package:rxdart/rxdart.dart';

class MemoGroupsBloc implements Bloc {
  MemoGroupsRepository _repository;
  List<MemoGroup> _memoGroups = <MemoGroup>[];

  BehaviorSubject<List<MemoGroup>> _memoGroupsController =
      BehaviorSubject<List<MemoGroup>>();
  BehaviorSubject<MemoGroup> _addGroupController = BehaviorSubject<MemoGroup>();
  BehaviorSubject<MemoGroup> _removeGroupController =
      BehaviorSubject<MemoGroup>();

  Sink<List<MemoGroup>> get _setGroups => _memoGroupsController.sink;

  Stream<List<MemoGroup>> get getAllGroups => _memoGroupsController.stream;

  Sink<MemoGroup> get addGroup => _addGroupController.sink;

  Sink<MemoGroup> get removeGroup => _removeGroupController.sink;

  MemoGroupsBloc() {
    void _onAdded(MemoGroup addedGroup) {
      _memoGroups.add(addedGroup);
      _setGroups.add(_memoGroups);
      Log.memoGroup.onAddedOnFirebase(addedGroup.asMap());
    }

    void _onRemoved(MemoGroup removedGroup) {
      _memoGroups.remove(removedGroup);
      _setGroups.add(_memoGroups);
      Log.memoGroup.onRemovedOnFirebase(removedGroup.asMap());
    }

    _repository = MemoGroupsRepository(
      onGroupAdded: _onAdded,
      onGroupRemoved: _onRemoved,
    );

    _addGroupController.stream.listen((MemoGroup memoGroup) {
      _repository.addGroup(memoGroup);
      Log.memoGroup.onAdded(memoGroup.asMap());
    });
    _removeGroupController.stream.listen((MemoGroup memoGroup) {
      _repository.removeGroup(memoGroup);
      Log.memoGroup.onRemoved(memoGroup.asMap());
    });
  }

  void dispose() async {
    _repository.dispose();

    await _memoGroupsController.close();
    await _addGroupController.close();
    await _removeGroupController.close();
  }
}
