import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note/models/memo.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/views/confirm_dialog.dart';

class CreateMemoPage extends StatefulWidget {
  final MemoGroup parentMemoGroup;

  const CreateMemoPage({Key key, @required this.parentMemoGroup}) : super(key: key);


  @override
  _CreateMemoPageState createState() => _CreateMemoPageState();
}

class _CreateMemoPageState extends State<CreateMemoPage> {
  String _memoTitle = '';
  String _memoBody = '';

  bool _wasInput() {
    return _memoTitle.isNotEmpty || _memoBody.isNotEmpty;
  }

  bool _canSave() {
    return _memoTitle.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = widget.parentMemoGroup.memosBloc;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Memo',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (_wasInput()) {
              ConfirmDialog.show(
                context,
                title: '変更があります、破棄して閉じますか？',
                onApproved: () {
                  Navigator.pop(context);
                },
              );
            } else {
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.close, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: _canSave()
                ? () {
                    bloc.addMemo.add(Memo(
                        title: _memoTitle,
                        body: _memoBody));
                    Navigator.pop(context);
                  }
                : null,
            icon: const Icon(FontAwesomeIcons.solidSave),
            color: Colors.blue,
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          TextField(
            style: TextStyle(fontSize: 30),
            onChanged: (value) {
              setState(() {
                _memoTitle = value;
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
              style: TextStyle(fontSize: 25),
              onChanged: (value) {
                setState(() {
                  _memoBody = value;
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
      ),
    );
  }
}
