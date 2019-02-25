import 'package:bloc_provider/bloc_provider.dart';
import 'package:note/firebase/memo_groups_repository.dart';
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
      print('add group = ${memoGroup.asMap()}');
      _repository.addGroup(memoGroup);
    });
    _removeGroupController.stream.listen((MemoGroup memoGroup) {
      print('remove group = ${memoGroup.asMap()}');
      _repository.removeGroup(memoGroup);
    });
    _updateGroupController.stream.listen((MemoGroup memoGroup) {
      print('update group = ${memoGroup.asMap()}');
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
