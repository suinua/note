import 'package:flutter/material.dart';
import 'package:note/models/memo.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:note/views/pages/memo_detail/preview_widget.dart';

class MemoDetailPage extends StatelessWidget {
  final Memo memo;

  const MemoDetailPage({Key key, this.memo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white30,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            ),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  child: Text('preview', style: TextStyle(color: Colors.black)),
                ),
                Tab(
                  child: Text(
                    'editing',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              MemoPreviewWidget(memo: memo),
              EditingMemoWidget(memo: memo),
            ],
          )),
    );
  }
}

class EditingMemoWidget extends StatefulWidget {
  final Memo memo;

  const EditingMemoWidget({Key key, this.memo}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          style: TextStyle(fontSize: 30),
          controller: _memoTitleController,
          onChanged: (value) {
            setState(() {
              widget.memo.title = value;
            });
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
              setState(() {
                widget.memo.body = value;
              });
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
