import 'package:flutter/material.dart';
import 'package:note/models/memo.dart';

class MemoWidget extends StatelessWidget {
  final Memo memo;

  const MemoWidget({Key key, @required this.memo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(memo.title),
        Divider(),
        _buildMemoBodyWidget(memo.body),
      ],
    );
  }

  Widget _buildMemoBodyWidget(String memoBody){
    return Text(memoBody);
  }
}