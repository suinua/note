import 'package:bloc_provider/bloc_provider.dart';
import 'package:note/log.dart';
import 'package:note/repositories/memo_groups_repository.dart';
import 'package:note/models/memo_group.dart';
import 'package:rxdart/rxdart.dart';

class MemoGroupsBloc implements Bloc{
  MemoGroupsRepository _repository;
  List<MemoGroup> _memoGroups = <MemoGroup>[];

  BehaviorSubject<List<MemoGroup>> _memoGroupsController =
      BehaviorSubject<List<MemoGroup>>();
  BehaviorSubject<MemoGroup> _addGroupController =
      BehaviorSubject<MemoGroup>();
  BehaviorSubject<MemoGroup> _removeGroupController =
      BehaviorSubject<MemoGroup>();
  BehaviorSubject<MemoGroup> _updateGroupController =
      BehaviorSubject<MemoGroup>();

  Sink<List<MemoGroup>> get _setGroups => _memoGroupsController.sink;

  Stream<List<MemoGroup>> get getAllGroups => _memoGroupsController.stream;

  Sink<MemoGroup> get addGroup => _addGroupController.sink;

  Sink<MemoGroup> get removeGroup => _removeGroupController.sink;

  Sink<MemoGroup> get updateGroup => _updateGroupController.sink;

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

    void _onChanged(MemoGroup changedGroup) {
      _memoGroups.forEach((MemoGroup memoGroup) {
        if (memoGroup == changedGroup) {
          memoGroup = changedGroup;
        }
      });
      _setGroups.add(_memoGroups);
      Log.memoGroup.onUpdatedOnFirebase(changedGroup.asMap());
    }

    _repository = MemoGroupsRepository(
        onGroupAdded: _onAdded,
        onGroupRemoved: _onRemoved,
        onGroupChanged: _onChanged);

    _addGroupController.stream.listen((MemoGroup memoGroup) {
      _repository.addGroup(memoGroup);
      Log.memoGroup.onAdded(memoGroup.asMap());
    });
    _removeGroupController.stream.listen((MemoGroup memoGroup) {
      _repository.removeGroup(memoGroup);
      Log.memoGroup.onRemoved(memoGroup.asMap());
    });
    _updateGroupController.stream.listen((MemoGroup memoGroup) {
      _repository.updateGroup(memoGroup);
      Log.memoGroup.onUpdated(memoGroup.asMap());
    });
  }

  void dispose() async {
    _repository.dispose();

    await _memoGroupsController.close();
    await _addGroupController.close();
    await _removeGroupController.close();
    await _updateGroupController.close();
  }
}
