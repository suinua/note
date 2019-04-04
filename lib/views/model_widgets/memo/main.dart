import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:note/blocs/memo/memos_bloc.dart';
import 'package:note/models/memo.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/models/memo_label.dart';
import 'package:note/providers/memo_bloc_provider.dart';
import 'package:note/providers/memo_group_provider.dart';
import 'package:note/views/confirm_dialog.dart';
import 'package:note/views/model_widgets/memo/menu.dart';
import 'package:note/views/model_widgets/memo_label/main.dart';
import 'package:note/views/pages/memo_groups/memo_group/memo/main.dart';

typedef void OnChanged(Memo memo);
typedef void OnRemoved(Memo memo);

class MemoWidget extends StatelessWidget {
  final Memo memo;

  const MemoWidget({Key key, @required this.memo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MemoGroup memoGroup = MemoGroupBlocProvider.of(context).value;
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
              MemoBlocProvider.of(context).setValue(memo);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MemoPage(),
                ),
              );
            },
            onLongPress: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (_) => MemoMenuWidget(memo: memo),
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
