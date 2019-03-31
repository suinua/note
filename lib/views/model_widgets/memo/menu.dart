import 'package:flutter/material.dart';
import 'package:note/blocs/memo_group/memo_group_bloc.dart';
import 'package:note/blocs/memo_group/template_memo_labels_bloc.dart';
import 'package:note/models/memo.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/models/memo_label.dart';
import 'package:note/models/template_memo_label.dart';
import 'package:note/views/model_widgets/memo_label/main.dart';
import 'package:note/views/model_widgets/template_memo_label/main.dart';
import 'package:provider/provider.dart';

enum _MemoMenuTypes {
  MenuList,
  Labels,
  SetLabel,
}

class MemoMenuWidget extends StatefulWidget {
  final Memo memo;

  const MemoMenuWidget({Key key, @required this.memo}) : super(key: key);

  @override
  _MemoMenuWidgetState createState() => _MemoMenuWidgetState();
}

class _MemoMenuWidgetState extends State<MemoMenuWidget> {
  _MemoMenuTypes _memoMenuTypes = _MemoMenuTypes.MenuList;

  Widget _menu() {
    switch (_memoMenuTypes) {
      case _MemoMenuTypes.MenuList:
        return _MenuList();
      case _MemoMenuTypes.Labels:
        return _Labels(memo: widget.memo);
      case _MemoMenuTypes.SetLabel:
        return _SetLabel();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return _menu();
  }
}

/* MenuList */
class _MenuList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        //TODO :　
      ],
    );
  }
}


/* Labels */

class _Labels extends StatelessWidget {
  final Memo memo;

  const _Labels({Key key, @required this.memo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      child: StreamBuilder<List<MemoLabel>>(
        stream: memo.labelsBloc.getAllLabels,
        builder: (_, AsyncSnapshot<List<MemoLabel>> labels) {
          if (labels.hasData) {
            return _buildLabels(labels.data);
          }
          return _buildLabels([]);
        },
      ),
    );
  }

  Widget _buildLabels(List<MemoLabel> labels) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: labels.length + 1,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, int index) {
        if (index == 0) {
          return IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: () {
              //TODO :
            },
          );
        }
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: MemoLabelWidget(
            label: labels[index - 1],
            onDelete: (label) {
              memo.labelsBloc.removeLabel.add(label);
            },
          ),
        );
      },
    );
  }
}

/* SetLabel */
class _SetLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MemoGroup memoGroup = Provider.of<MemoGroupBloc>(context).value;
    final TemplateMemoLabelsBloc _templateMemoLabelsBloc =
        memoGroup.templateMemoLabelsBloc;

    return Container(
      height: 60.0,
      child: StreamBuilder<List<TemplateMemoLabel>>(
        stream: _templateMemoLabelsBloc.getAllLabels,
        builder: (_, AsyncSnapshot<List<TemplateMemoLabel>> labels) {
          if (labels.hasData) {
            return _buildTemplateLabels(labels.data);
          }
          return _buildTemplateLabels([]);
        },
      ),
    );
  }

  Widget _buildTemplateLabels(List<TemplateMemoLabel> labels) {
    //TODO : 既にMemoについているLabelを削除。
    //TODO : Labelをタップで付与。

    return ListView.builder(
      shrinkWrap: true,
      itemCount: labels.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, int index) {
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: TemplateMemoLabelWidget(label: labels[index]),
        );
      },
    );
  }
}
