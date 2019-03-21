import 'package:flutter/material.dart';
import 'package:note/blocs/providers/memos_bloc_provider.dart';
import 'package:note/models/memo.dart';

class EditingMemoWidget extends StatefulWidget {
  final Memo memo;

  const EditingMemoWidget({Key key, @required this.memo}) : super(key: key);

  @override
  _EditingMemoWidgetState createState() => _EditingMemoWidgetState();
}

class _EditingMemoWidgetState extends State<EditingMemoWidget> {
  //初期値用
  TextEditingController _memoTitleController;
  TextEditingController _memoBodyController;

  @override
  void initState() {
    _memoTitleController = TextEditingController(text: widget.memo.title);
    _memoBodyController = TextEditingController(text: widget.memo.body);

    super.initState();
  }

  Widget build(BuildContext context) {
    final bloc = MemosBlocProvider.of(context);

    return Column(
      children: <Widget>[
        TextField(
          style: TextStyle(fontSize: 30),
          controller: _memoTitleController,
          onChanged: (value) {
            widget.memo.title = value;

            bloc.updateMemo.add(widget.memo);
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
              widget.memo.body = value;

              bloc.updateMemo.add(widget.memo);
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