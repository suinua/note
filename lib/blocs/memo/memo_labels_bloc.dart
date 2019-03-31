import 'package:bloc_provider/bloc_provider.dart';
import 'package:note/log.dart';
import 'package:note/models/memo_label.dart';
import 'package:note/repositories/memo_labels_repository.dart';
import 'package:rxdart/rxdart.dart';

class MemoLabelsBloc extends Bloc {
  final String parentGroupKey;
  final String ownerMemoKey;
  MemoLabelsRepository _repository;
  List<MemoLabel> _labels = <MemoLabel>[];

  BehaviorSubject<List<MemoLabel>> _labelsController =
      BehaviorSubject<List<MemoLabel>>();
  BehaviorSubject<MemoLabel> _addLabelController = BehaviorSubject<MemoLabel>();
  BehaviorSubject<MemoLabel> _removeLabelController =
      BehaviorSubject<MemoLabel>();
  BehaviorSubject<MemoLabel> _updateLabelController =
      BehaviorSubject<MemoLabel>();

  Sink<List<MemoLabel>> get _setLabels => _labelsController.sink;

  Stream<List<MemoLabel>> get getAllLabels => _labelsController.stream;

  Sink<MemoLabel> get addLabel => _addLabelController.sink;

  Sink<MemoLabel> get removeLabel => _removeLabelController.sink;

  Sink<MemoLabel> get updateLabel => _updateLabelController.sink;

  MemoLabelsBloc(this.parentGroupKey, this.ownerMemoKey) {
    void _onAdded(MemoLabel addedLabel) {
      _labels.add(addedLabel);
      _setLabels.add(_labels);
      Log.label.onAddedOnFirebase(addedLabel.asMap());
    }

    void _onRemoved(MemoLabel removedLabel) {
      _labels.remove(removedLabel);
      _setLabels.add(_labels);
      Log.label.onRemovedOnFirebase(removedLabel.asMap());
    }

    void _onChanged(MemoLabel changedLabel) {
      _labels.forEach((MemoLabel label) {
        if (label == changedLabel) {
          label = changedLabel;
        }
      });
      _setLabels.add(_labels);
      Log.label.onUpdatedOnFirebase(changedLabel.asMap());
    }

    _repository = MemoLabelsRepository(parentGroupKey, ownerMemoKey,
        onLabelAdded: _onAdded,
        onLabelRemoved: _onRemoved,
        onLabelChanged: _onChanged);

    _addLabelController.stream.listen((MemoLabel label) {
      _repository.addLabel(label);
      Log.label.onUpdated(label.asMap());
    });
    _removeLabelController.stream.listen((MemoLabel label) {
      _repository.removeLabel(label);
      Log.label.onUpdated(label.asMap());
    });
    _updateLabelController.stream.listen((MemoLabel label) {
      _repository.updateLabel(label);
      Log.label.onUpdated(label.asMap());
    });
  }

  void dispose() async {
    await _labelsController.close();
    await _addLabelController.close();
    await _removeLabelController.close();
    await _updateLabelController.close();
  }
}
