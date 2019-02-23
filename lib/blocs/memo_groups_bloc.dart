import 'dart:async';

import 'package:bloc_provider/bloc_provider.dart';
import 'package:note/firebase/memo_groups_repository.dart';
import 'package:note/models/memo_group.dart';

class MemoGroupsBloc implements Bloc{
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

  StreamSink<MemoGroup> get addGroup => _addGroupController.sink;

  StreamSink<MemoGroup> get removeGroup => _removeGroupController.sink;

  StreamSink<MemoGroup> get updateGroup => _updateGroupController.sink;

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

    _addGroupController.stream.listen((MemoGroup memoGroup) {
      _repository.addGroup(memoGroup);
    });
    _removeGroupController.stream.listen((MemoGroup memoGroup) {
      _repository.removeGroup(memoGroup);
    });
    _updateGroupController.stream.listen((MemoGroup memoGroup) {
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