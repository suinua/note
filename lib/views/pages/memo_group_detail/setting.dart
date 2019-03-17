import 'package:flutter/material.dart';
import 'package:note/blocs/providers/memo_groups_bloc_provider.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/views/confirm_dialog.dart';

class MemoGroupSettingPage extends StatefulWidget {
  final MemoGroup memoGroup;

  const MemoGroupSettingPage({Key key, @required this.memoGroup})
      : super(key: key);

  @override
  _MemoGroupSettingPageState createState() => _MemoGroupSettingPageState();
}

class _MemoGroupSettingPageState extends State<MemoGroupSettingPage> {
  //TODO : TextEditingControllerは、文字を入力した瞬間更新されないので_canSave関数の反映が遅れてしまう(?)
  String _mockTitle;
  String _mockDescription;
  TextEditingController _mockTitleController;
  TextEditingController _mockDescriptionController;

  @override
  void initState() {
    _mockTitleController = TextEditingController(text: widget.memoGroup.title);
    _mockDescriptionController =
        TextEditingController(text: widget.memoGroup.description);

    _mockTitle = widget.memoGroup.title;
    _mockDescription = widget.memoGroup.description;

    super.initState();
  }

  bool _canSave() {
    return _mockTitle != widget.memoGroup.title ||
        _mockDescription != widget.memoGroup.description;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = MemoGroupsBlocProvider.of(context);
    //TODO : 並び替え、
    return Scaffold(
      //TODO : 削除ボタンの位置、キーボードが上がると画面からはみ出てしまう。
      appBar: AppBar(
        title: Text(
          'New Memo Group',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (_canSave()) {
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
          Center(
            child: RaisedButton(
              onPressed: _canSave()
                  ? () {
                      setState(() {
                        widget.memoGroup.title = _mockTitleController.text;
                        widget.memoGroup.description =
                            _mockDescriptionController.text;
                      });
                      bloc.updateGroup.add(widget.memoGroup);
                    }
                  : null,
              child: Text('save'),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _mockTitleController,
            style: TextStyle(fontSize: 30),
            onChanged: (value) {
              setState(() {
                _mockTitle = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Title',
              border: InputBorder.none,
            ),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 30.0)),
          TextField(
            controller: _mockDescriptionController,
            style: TextStyle(fontSize: 25),
            onChanged: (value) {
              setState(() {
                _mockDescription = value;
              });
            },
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'Description',
              border: InputBorder.none,
            ),
          ),
          RaisedButton(
            onPressed: () {
              ConfirmDialog.show(
                context,
                title: '削除しますか?',
                onApproved: () {
                  bloc.removeGroup.add(widget.memoGroup);
                },
              );
            },
            child: const Text('delete'),
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ],
      ),
    );
  }
}
