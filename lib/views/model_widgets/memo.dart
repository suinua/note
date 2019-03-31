import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:note/blocs/memo/memos_bloc.dart';
import 'package:note/blocs/memo_group/template_memo_labels_bloc.dart';
import 'package:note/blocs/memo_group/memo_group_bloc.dart';
import 'package:note/models/memo.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/models/memo_label.dart';
import 'package:note/models/template_memo_label.dart';
import 'package:note/views/confirm_dialog.dart';
import 'package:note/views/model_widgets/memo_label.dart';
import 'package:note/views/model_widgets/template_memo_label.dart';
import 'package:note/views/pages/memo_groups/memo_group/memo/main.dart';
import 'package:provider/provider.dart';

typedef void OnChanged(Memo memo);
typedef void OnRemoved(Memo memo);

class MemoWidget extends StatelessWidget {
  final Memo memo;

  const MemoWidget({Key key, @required this.memo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MemoGroup memoGroup = Provider.of<MemoGroupBloc>(context).value;
    final MemosBloc memosBloc = memoGroup.memosBloc;

    return Slidable(
      delegate: SlidableDrawerDelegate(),
      actionExtentRatio: 0.25,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(memo.title),
            subtitle: Text(
              memo.body,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return MemoPage(memo: memo);
                  },
                ),
              );
            },
            onLongPress: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (_) => _MemoLabelsMenu(memo: memo),
              );
            },
          ),
          StreamBuilder<List<MemoLabel>>(
            stream: memo.labelsBloc.getAllLabels,
            builder:
                (BuildContext context, AsyncSnapshot<List<MemoLabel>> labels) {
              if (labels.hasData) {
                return _buildLabels(labels.data);
              }
              return _buildLabels([]);
            },
          ),
        ],
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            ConfirmDialog.show(
              context,
              title: memo.title,
              body: '削除しますか？',
              onApproved: () {
                memosBloc.removeMemo.add(memo);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildLabels(List<MemoLabel> labels) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Wrap(
        alignment: WrapAlignment.start,
        children: labels.map((label) => MemoLabelWidget(label: label)).toList(),
      ),
    );
  }
}

enum _DisplayLabelsType {
  MemoLabels,
  Templates,
}

class _MemoLabelsMenu extends StatefulWidget {
  final Memo memo;

  const _MemoLabelsMenu({Key key, @required this.memo}) : super(key: key);

  @override
  __MemoLabelsMenuState createState() => __MemoLabelsMenuState();
}

class __MemoLabelsMenuState extends State<_MemoLabelsMenu> {
  _DisplayLabelsType _displayLabelsType = _DisplayLabelsType.MemoLabels;

  @override
  Widget build(BuildContext context) {
    final MemoGroup memoGroup = Provider.of<MemoGroupBloc>(context).value;
    final TemplateMemoLabelsBloc _templateMemoLabelsBloc =
        memoGroup.templateMemoLabelsBloc;

    return Container(
      height: 60.0,
      child: _displayLabelsType == _DisplayLabelsType.MemoLabels
          ? StreamBuilder<List<MemoLabel>>(
              stream: widget.memo.labelsBloc.getAllLabels,
              builder: (_, AsyncSnapshot<List<MemoLabel>> labels) {
                if (labels.hasData) {
                  return _buildLabelList(labels.data);
                }
                return _buildLabelList([]);
              },
            )
          : StreamBuilder<List<TemplateMemoLabel>>(
              stream: _templateMemoLabelsBloc.getAllLabels,
              builder: (_, AsyncSnapshot<List<TemplateMemoLabel>> labels) {
                if (labels.hasData) {
                  return _buildTemplateLabelList(labels.data);
                }
                return _buildTemplateLabelList([]);
              },
            ),
    );
  }

  Widget _buildTemplateLabelList(List<TemplateMemoLabel> labels) {
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

  Widget _buildLabelList(List<MemoLabel> labels) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: labels.length + 1,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, int index) {
        if (index == 0) {
          return IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: () {
              setState(() {
                _displayLabelsType = _DisplayLabelsType.Templates;
              });
            },
          );
        }
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: MemoLabelWidget(
            label: labels[index - 1],
            onDelete: (label) {
              widget.memo.labelsBloc.removeLabel.add(label);
            },
          ),
        );
      },
    );
  }
}
