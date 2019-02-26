import 'package:flutter/material.dart';
import 'package:note/models/memo_group.dart';

class CreateMemoBottomSheet extends StatelessWidget {
  final MemoGroup memoGroup;

  const CreateMemoBottomSheet({Key key, @required this.memoGroup})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO : メモ作成ページ
    return Scaffold(
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
