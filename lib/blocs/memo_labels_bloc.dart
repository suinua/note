import 'package:note/models/memo_label.dart';
import 'package:note/repositorys/memo_labels_repository.dart';
import 'package:rxdart/rxdart.dart';

class MemoLabelsBloc {
  final String parentGroupKey;
  MemoLabelsRepository _repository;
  List<MemoLabel> _labels = <MemoLabel>[];

  BehaviorSubject<List<MemoLabel>> _labelsController = BehaviorSubject<List<MemoLabel>>();
  BehaviorSubject<MemoLabel> _addLabelController = BehaviorSubject<MemoLabel>();
  BehaviorSubject<MemoLabel> _removeLabelController = BehaviorSubject<MemoLabel>();
  BehaviorSubject<MemoLabel> _updateLabelController = BehaviorSubject<MemoLabel>();

  Sink<List<MemoLabel>> get _setLabels => _labelsController.sink;

  Stream<List<MemoLabel>> get getAllLabels => _labelsController.stream;

  Sink<MemoLabel> get addLabel => _addLabelController.sink;

  Sink<MemoLabel> get removeLabel => _removeLabelController.sink;

  Sink<MemoLabel> get updateLabel => _updateLabelController.sink;

  MemoLabelsBloc(this.parentGroupKey) {
    void _onAdded(MemoLabel addedLabel) {
      print('added label to firebase : ${addedLabel.asMap()}');

      _labels.add(addedLabel);
      _setLabels.add(_labels);
    }

    void _onRemoved(MemoLabel removedLabel) {
      print('removed label to firebase : ${removedLabel.asMap()}');

      _labels.remove(removedLabel);
      _setLabels.add(_labels);
    }

    void _onChanged(MemoLabel changedLabel) {
      print('updated label to firebase : ${changedLabel.asMap()}');

      _labels.forEach((MemoLabel label) {
        if (label == changedLabel) {
          label = changedLabel;
        }
      });
      _setLabels.add(_labels);
    }

    _repository = MemoLabelsRepository(parentGroupKey,
        onLabelAdded: _onAdded,
        onLabelRemoved: _onRemoved,
        onLabelChanged: _onChanged);

    _addLabelController.stream.listen((MemoLabel label) {
      print('add label : ${label.asMap()}');
      _repository.addLabel(label);
    });
    _removeLabelController.stream.listen((MemoLabel label) {
      print('remove label : ${label.asMap()}');
      _repository.removeLabel(label);
    });
    _updateLabelController.stream.listen((MemoLabel label) {
      print('update label : ${label.asMap()}');
      _repository.updateLabel(label);
    });
  }

  void dispose() async {
    await _labelsController.close();
    await _addLabelController.close();
    await _removeLabelController.close();
    await _updateLabelController.close();
  }
}
