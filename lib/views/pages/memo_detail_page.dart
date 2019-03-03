import 'package:flutter/material.dart';
import 'package:note/models/memo.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:note/views/pages/editing_memo_widget.dart';

class MemoDetailPage extends StatelessWidget {
  final Memo memo;

  const MemoDetailPage({Key key, this.memo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Color.fromRGBO(204, 204, 204, 0.5);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              memo.title,
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
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
              Markdown(
                data: memo.body,
                styleSheet: MarkdownStyleSheet.fromTheme(
                  ThemeData(
                      textTheme: TextTheme(
                    display4: TextStyle(fontSize: 11.0 * 2.0),
                    display3: TextStyle(fontSize: 56.0 * 2.0),
                    display2: TextStyle(fontSize: 45.0 * 2.0),
                    display1: TextStyle(fontSize: 34.0 * 2.0),
                    headline: TextStyle(
                      fontSize: 24.0 * 2.0,
                      decoration: TextDecoration.underline,
                      decorationColor: color,
                    ),
                    title: TextStyle(
                      fontSize: 20.0 * 2.0,
                      decoration: TextDecoration.underline,
                      decorationColor: color,
                    ),
                    subhead: TextStyle(
                      fontSize: 16.0 * 2.0,
                      decoration: TextDecoration.underline,
                      decorationColor: color,
                    ),
                    body2: TextStyle(
                      fontSize: 14.0 * 2.0,
                      decoration: TextDecoration.underline,
                      decorationColor: color,
                    ),
                    body1: TextStyle(fontSize: 14.0 * 2.0),
                    caption: TextStyle(fontSize: 12.0 * 2.0),
                    button: TextStyle(fontSize: 14.0 * 2.0),
                    subtitle: TextStyle(fontSize: 14.0 * 2.0),
                    overline: TextStyle(fontSize: 10.0 * 2.0),
                  )),
                ),
              ),
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
    _memoTitleController = TextEditingController(text:widget.memo.title);
    _memoBodyController = TextEditingController(text:widget.memo.body);

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