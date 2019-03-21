import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:note/models/memo.dart';
import 'package:note/views/confirm_dialog.dart';
import 'package:note/views/pages/memo_groups/memo_group/memo_detail/main.dart';

typedef void OnChanged(Memo memo);
typedef void OnRemoved(Memo memo);

class MemoWidget extends StatelessWidget {
  final Memo memo;
  final OnChanged onChanged;
  final OnRemoved onRemoved;

  const MemoWidget(
      {Key key,
      @required this.memo,
      @required this.onRemoved,
      @required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      delegate: SlidableDrawerDelegate(),
      actionExtentRatio: 0.25,
      child: ListTile(
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
                return MemoDetailPage(memo: memo,onChanged: onChanged);
              },
            ),
          );
        },
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
                onRemoved(memo);
              },
            );
          },
        ),
      ],
    );
  }
}
