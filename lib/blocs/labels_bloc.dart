import 'package:note/models/label.dart';
import 'package:note/repositorys/labels_repository.dart';
import 'package:rxdart/rxdart.dart';

class LabelsBloc {
  final String parentGroupKey;
  LabelsRepository _repository;
  List<Label> _labels = <Label>[];

  BehaviorSubject<List<Label>> _labelsController = BehaviorSubject<List<Label>>();
  BehaviorSubject<Label> _addLabelController = BehaviorSubject<Label>();
  BehaviorSubject<Label> _removeLabelController = BehaviorSubject<Label>();
  BehaviorSubject<Label> _updateLabelController = BehaviorSubject<Label>();

  Sink<List<Label>> get _setLabels => _labelsController.sink;

  Stream<List<Label>> get getAllLabels => _labelsController.stream;

  Sink<Label> get addLabel => _addLabelController.sink;

  Sink<Label> get removeLabel => _removeLabelController.sink;

  Sink<Label> get updateLabel => _updateLabelController.sink;

  LabelsBloc(this.parentGroupKey) {
    void _onAdded(Label addedLabel) {
      print('added label to firebase : ${addedLabel.asMap()}');

      _labels.add(addedLabel);
      _setLabels.add(_labels);
    }

    void _onRemoved(Label removedLabel) {
      print('removed label to firebase : ${removedLabel.asMap()}');

      _labels.remove(removedLabel);
      _setLabels.add(_labels);
    }

    void _onChanged(Label changedLabel) {
      print('updated label to firebase : ${changedLabel.asMap()}');

      _labels.forEach((Label label) {
        if (label == changedLabel) {
          label = changedLabel;
        }
      });
      _setLabels.add(_labels);
    }

    _repository = LabelsRepository(parentGroupKey,
        onLabelAdded: _onAdded,
        onLabelRemoved: _onRemoved,
        onLabelChanged: _onChanged);

    _addLabelController.stream.listen((Label label) {
      print('add label : ${label.asMap()}');
      _repository.addLabel(label);
    });
    _removeLabelController.stream.listen((Label label) {
      print('remove label : ${label.asMap()}');
      _repository.removeLabel(label);
    });
    _updateLabelController.stream.listen((Label label) {
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
