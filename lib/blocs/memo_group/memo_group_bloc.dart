import 'package:bloc_provider/bloc_provider.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/repositories/memo_group_repository.dart';
import 'package:rxdart/rxdart.dart';

class MemoGroupBloc implements Bloc {
  MemoGroup _memoGroup;

  BehaviorSubject<MemoGroup> _memoGroupController =
      BehaviorSubject<MemoGroup>();

  Sink<MemoGroup> get _setValue => _memoGroupController.sink;

  Stream<MemoGroup> get getValue => _memoGroupController.stream;

  BehaviorSubject<MemoGroup> _resetGroupController =
      BehaviorSubject<MemoGroup>();

  Sink<MemoGroup> get resetGroup => _resetGroupController.sink;

  BehaviorSubject<String> _updateTitleController = BehaviorSubject<String>();

  Sink<String> get updateTitle => _updateTitleController.sink;

  BehaviorSubject<String> _updateDescriptionController =
      BehaviorSubject<String>();

  Sink<String> get updateDescription => _updateDescriptionController.sink;

  MemoGroupsRepository _repository;

  MemoGroupBloc() {
    _resetGroupController.stream.listen((MemoGroup memoGroup) {
      _repository?.dispose();
      _memoGroup = memoGroup;
      _setValue.add(_memoGroup);

      _repository = MemoGroupsRepository(
        groupKey: _memoGroup.key,
        onTitleChanged: (String title) {
          _memoGroup.title = title;
          _setValue.add(_memoGroup);
        },
        onDescriptionChanged: (String description) {
          _memoGroup.description = description;
          _setValue.add(_memoGroup);
        },
      );
    });
    _updateTitleController.stream.listen((String title) {
      _repository.updateGroup(title: title);
    });
    _updateDescriptionController.stream.listen((String description) {
      _repository.updateGroup(description: description);
    });
  }

  @override
  void dispose() async {
    _repository?.dispose();

    await _memoGroupController.drain();
    await _resetGroupController.drain();
    await _updateTitleController.drain();
    await _updateDescriptionController.drain();

    await _memoGroupController.close();
    await _resetGroupController.close();
    await _updateTitleController.close();
    await _updateDescriptionController.close();
  }
}
