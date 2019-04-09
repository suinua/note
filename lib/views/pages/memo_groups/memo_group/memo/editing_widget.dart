import 'package:flutter/material.dart';
import 'package:note/blocs/memo/memos_bloc.dart';
import 'package:note/models/memo.dart';
import 'package:note/providers/memo_bloc_provider.dart';
import 'package:note/providers/memos_bloc_provider.dart';

class EditingMemoWidget extends StatefulWidget {
  final String seedTitleValue;
  final String seedBodyValue;

  const EditingMemoWidget(
      {Key key, @required this.seedTitleValue, @required this.seedBodyValue})
      : super(key: key);

  @override
  _EditingMemoWidgetState createState() => _EditingMemoWidgetState();
}

class _EditingMemoWidgetState extends State<EditingMemoWidget> {
  //初期値用
  TextEditingController _memoTitleController;
  TextEditingController _memoBodyController;

  @override
  void initState() {
    _memoTitleController = TextEditingController(text: widget.seedTitleValue);
    _memoBodyController = TextEditingController(text: widget.seedBodyValue);

    super.initState();
  }

  @override
  void dispose() {
    _memoTitleController.dispose();
    _memoBodyController.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    final MemosBloc memosBloc = MemosBlocProvider.of(context);

    Memo memo = MemoBlocProvider.of(context).value;

    return Column(
      children: <Widget>[
        TextField(
          style: TextStyle(fontSize: 30),
          controller: _memoTitleController,
          onChanged: (value) {
            memo.title = value;
            memosBloc.updateMemo.add(memo);
          },
          decoration: InputDecoration(
            hintText: 'Title',
            border: InputBorder.none,
          ),
        ),
        Divider(),
        Padding(padding: const EdgeInsets.only(bottom: 30.0)),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: _memoBodyController,
            style: TextStyle(fontSize: 25),
            onChanged: (value) {
              memo.body = value;
              memosBloc.updateMemo.add(memo);
            },
            decoration: InputDecoration(
              hintText: 'Body',
              border: InputBorder.none,
            ),
          ),
        ),
        Divider(),
        //MEMO : キーボードで文字が隠れるのを防ぐため
        Padding(padding: const EdgeInsets.only(bottom: 40.0)),
      ],
    );
  }
}
