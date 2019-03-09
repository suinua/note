import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:note/models/memo.dart';
import 'package:note/views/confirm_dialog.dart';
import 'package:note/views/pages/memo_detail/main.dart';

class MemoWidget extends StatelessWidget {
  final Memo memo;

  const MemoWidget({Key key, @required this.memo}) : super(key: key);

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
                return MemoDetailPage(memo: memo);
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
                memo.remove();
              },
            );
          },
        ),
      ],
    );
  }
}
