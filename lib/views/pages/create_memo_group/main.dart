import 'package:flutter/material.dart';
import 'package:note/blocs/memo_groups_bloc_provider.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/views/confirm_dialog.dart';

class CreateMemoGroupPage extends StatefulWidget {
  @override
  _CreateMemoGroupPageState createState() => _CreateMemoGroupPageState();
}

class _CreateMemoGroupPageState extends State<CreateMemoGroupPage> {
  String _groupTitle = '';
  String _groupDescription = '';

  bool _wasInput() {
    return _groupTitle.isNotEmpty || _groupDescription.isNotEmpty;
  }

  bool _canSave() {
    return _groupTitle.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = MemoGroupsBlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Memo Group',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
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
          Center(
            child: IconButton(
              onPressed: _canSave()
                  ? () {
                      //TODO : タップしたらその作ったグループのページに移行
                      bloc.addGroup.add(MemoGroup(
                          title: _groupTitle, description: _groupDescription));
                      Navigator.pop(context);
                    }
                  : null,
              icon: const Icon(Icons.save),
              color: Colors.blue,
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          TextField(
            style: TextStyle(fontSize: 30),
            onChanged: (value) {
              setState(() {
                _groupTitle = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Title',
              border: InputBorder.none,
            ),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 30.0)),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(fontSize: 25),
              onChanged: (value) {
                setState(() {
                  _groupDescription = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Description',
                border: InputBorder.none,
              ),
            ),
          ),
          //MEMO : キーボードで文字が隠れるのを防ぐため
          Padding(padding: const EdgeInsets.only(bottom: 40.0)),
        ],
      ),
    );
  }
}