import 'package:bloc_provider/bloc_provider.dart';
import 'package:note/log.dart';
import 'package:note/models/template_memo_label.dart';
import 'package:note/repositories/template_memo_labels_repository.dart';
import 'package:rxdart/rxdart.dart';

class TemplateMemoLabelsBloc extends Bloc {
  TemplateMemoLabelsBloc(this.parentGroupKey){
    _repository = TemplateMemoLabelsRepository(
      parentGroupKey,
      onLabelAdded: _onAdded,
      onLabelRemoved: _onRemoved,
      onLabelChanged: _onChanged,
    );
    _setListener();
  }

  final String parentGroupKey;
  TemplateMemoLabelsRepository _repository;
  List<TemplateMemoLabel> _labels = <TemplateMemoLabel>[];

  BehaviorSubject<List<TemplateMemoLabel>> _labelsController =
      BehaviorSubject<List<TemplateMemoLabel>>();
  BehaviorSubject<TemplateMemoLabel> _addLabelController =
      BehaviorSubject<TemplateMemoLabel>();
  BehaviorSubject<TemplateMemoLabel> _removeLabelController =
      BehaviorSubject<TemplateMemoLabel>();
  BehaviorSubject<TemplateMemoLabel> _updateLabelController =
      BehaviorSubject<TemplateMemoLabel>();

  Sink<List<TemplateMemoLabel>> get _setLabels => _labelsController.sink;

  Stream<List<TemplateMemoLabel>> get getAllLabels => _labelsController.stream;

  Sink<TemplateMemoLabel> get addLabel => _addLabelController.sink;

  Sink<TemplateMemoLabel> get removeLabel => _removeLabelController.sink;

  Sink<TemplateMemoLabel> get updateLabel => _updateLabelController.sink;

  void _onAdded(TemplateMemoLabel addedLabel) {
    _labels.add(addedLabel);
    _setLabels.add(_labels);
    Log.templateLabel.onAddedOnFirebase(addedLabel.asMap());
  }

  void _onRemoved(TemplateMemoLabel removedLabel) {
    _labels.remove(removedLabel);
    _setLabels.add(_labels);
    Log.templateLabel.onRemovedOnFirebase(removedLabel.asMap());
  }

  void _onChanged(TemplateMemoLabel changedLabel) {
    _labels.forEach((TemplateMemoLabel label) {
      if (label == changedLabel) {
        label = changedLabel;
      }
    });
    _setLabels.add(_labels);
    Log.templateLabel.onUpdatedOnFirebase(changedLabel.asMap());
  }

  void _setListener() {
    _addLabelController.stream.listen((TemplateMemoLabel label) {
      _repository.addLabel(label);
      Log.templateLabel.onUpdated(label.asMap());
    });
    _removeLabelController.stream.listen((TemplateMemoLabel label) {
      _repository.removeLabel(label);
      Log.templateLabel.onUpdated(label.asMap());
    });
    _updateLabelController.stream.listen((TemplateMemoLabel label) {
      _repository.updateLabel(label);
      Log.templateLabel.onUpdated(label.asMap());
    });
  }

  void dispose() async {
    _labels = <TemplateMemoLabel>[];
    _repository?.dispose();

    await _labelsController.drain();
    await _addLabelController.drain();
    await _removeLabelController.drain();
    await _updateLabelController.drain();

    await _labelsController.close();
    await _addLabelController.close();
    await _removeLabelController.close();
    await _updateLabelController.close();
  }
}
