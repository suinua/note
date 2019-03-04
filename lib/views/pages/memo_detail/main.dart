import 'package:flutter/material.dart';
import 'package:note/models/memo.dart';
import 'package:note/views/pages/memo_detail/editing_widget.dart';
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