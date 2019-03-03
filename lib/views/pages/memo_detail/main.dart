import 'package:flutter/material.dart';
import 'package:note/models/memo.dart';
import 'package:note/views/pages/memo_detail/preview_widget.dart';

class _DisplayMode {
  final String _mode;

  _DisplayMode._(this._mode);

  static final preview = _DisplayMode._('preview');
  static final editing = _DisplayMode._('editing');

  bool get isPreview => _mode == 'preview';

  bool get isEditing => _mode == 'editing';
}

class MemoDetailPage extends StatefulWidget {
  final Memo memo;

  const MemoDetailPage({Key key, this.memo}) : super(key: key);

  @override
  _MemoDetailPageState createState() => _MemoDetailPageState();
}

class _MemoDetailPageState extends State<MemoDetailPage> {
  _DisplayMode _displayMode = _DisplayMode.preview;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white30,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.mode_edit,
                color: _displayMode.isEditing ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _displayMode = _displayMode.isEditing
                      ? _DisplayMode.preview
                      : _DisplayMode.editing;
                });
              }),
        ],
      ),
      body: _displayMode.isPreview
          ? MemoPreviewWidget(memo: widget.memo)
          : EditingMemoWidget(memo: widget.memo),
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
