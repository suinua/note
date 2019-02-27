import 'package:flutter/material.dart';
import 'package:note/models/memo.dart';
import 'package:note/views/pages/memo_detail_page.dart';

class MemoWidget extends StatelessWidget {
  final Memo memo;

  const MemoWidget({Key key, @required this.memo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(memo.title),
          subtitle: _buildMemoBodyWidget(memo.body),
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
        Divider(),
      ],
    );
  }

  //TODO : bodyデータは複雑になる可能性があるため
  Widget _buildMemoBodyWidget(String memoBody) {
    return Text(
      memoBody,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}
