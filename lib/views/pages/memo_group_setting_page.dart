import 'package:flutter/material.dart';
import 'package:note/blocs/memo_groups_bloc_provider.dart';
import 'package:note/models/memo_group.dart';

class MemoGroupSettingPage extends StatefulWidget {
  final MemoGroup memoGroup;

  const MemoGroupSettingPage({Key key, @required this.memoGroup}) : super(key: key);

  @override
  _MemoGroupSettingPageState createState() => _MemoGroupSettingPageState();
}

class _MemoGroupSettingPageState extends State<MemoGroupSettingPage> {
  //TODO : TextEditingControllerは、文字を入力した瞬間更新されないので_canSave関数の反映が遅れてしまう(?)
  TextEditingController _mockTitleController;
  TextEditingController _mockDescriptionController;

  @override
  void initState() {
    _mockTitleController = TextEditingController(text: widget.memoGroup.title);
    _mockDescriptionController =
        TextEditingController(text: widget.memoGroup.description);

    super.initState();
  }

  bool _canSave() {
    return _mockTitleController.text != widget.memoGroup.title &&
        _mockDescriptionController.text != widget.memoGroup.description;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = MemoGroupsBlocProvider.of(context);
    //TODO :　リネーム、 削除、 並び替え、
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'New Memo Group',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white30,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.black),
        ),
        actions: <Widget>[
          Center(
            child: RaisedButton(
              onPressed: _canSave()
                  ? () {
                      widget.memoGroup.title = _mockTitleController.text;
                      widget.memoGroup.description =
                          _mockDescriptionController.text;
                      bloc.updateGroup.add(widget.memoGroup);
                      Navigator.pop(context);
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
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 30.0)),
          TextField(
            controller: _mockDescriptionController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}