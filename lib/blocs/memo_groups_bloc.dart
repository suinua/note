import 'dart:async';

import 'package:note/firebase/memo_groups_repository.dart';
import 'package:note/models/memo_group.dart';

class MemoGroupsBloc {
  MemoGroupsRepository _repository;
  List<MemoGroup> _memoGroups = <MemoGroup>[];

  StreamController<List<MemoGroup>> _memoGroupsController =
      StreamController<List<MemoGroup>>();
  StreamController<MemoGroup> _addGroupController =
      StreamController<MemoGroup>();
  StreamController<MemoGroup> _removeGroupController =
      StreamController<MemoGroup>();
  StreamController<MemoGroup> _updateGroupController =
      StreamController<MemoGroup>();

  StreamSink<List<MemoGroup>> get _setGroups => _memoGroupsController.sink;

  Stream<List<MemoGroup>> get getAllGroups => _memoGroupsController.stream;

  Stream<MemoGroup> get addGroup => _addGroupController.stream;

  Stream<MemoGroup> get removeGroup => _removeGroupController.stream;

  Stream<MemoGroup> get updateGroup => _updateGroupController.stream;

  MemoGroupsBloc() {
    void _onAdded(MemoGroup addedGroup) {
      _memoGroups.add(addedGroup);
      _setGroups.add(_memoGroups);
    }

    void _onRemoved(MemoGroup removedGroup) {
      _memoGroups.remove(removedGroup);
      _setGroups.add(_memoGroups);
    }

    void _onChanged(MemoGroup changedGroup) {
      _memoGroups.forEach((MemoGroup memoGroup) {
        if (memoGroup == changedGroup) {
          memoGroup = changedGroup;
        }
      });
      _setGroups.add(_memoGroups);
    }

    _repository = MemoGroupsRepository(
        onGroupAdded: _onAdded,
        onGroupRemoved: _onRemoved,
        onGroupChanged: _onChanged);

    addGroup.listen((MemoGroup memoGroup) {
      _repository.addGroup(memoGroup);
    });
    removeGroup.listen((MemoGroup memoGroup) {
      _repository.removeGroup(memoGroup);
    });
    updateGroup.listen((MemoGroup memoGroup) {
      _repository.updateGroup(memoGroup);
    });
  }

  void dispose() async {
    await _memoGroupsController.close();
    await _addGroupController.close();
    await _removeGroupController.close();
    await _updateGroupController.close();
  }
}
