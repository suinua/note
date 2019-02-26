import 'package:flutter/material.dart';
import 'package:note/models/memo.dart';
import 'package:note/models/memo_group.dart';

class CreateMemoBottomSheet extends StatefulWidget {
  final MemoGroup memoGroup;

  const CreateMemoBottomSheet({Key key, @required this.memoGroup})
      : super(key: key);

  @override
  _CreateMemoBottomSheetState createState() => _CreateMemoBottomSheetState();
}

class _CreateMemoBottomSheetState extends State<CreateMemoBottomSheet> {
  String _memoTitle = '';
  String _memoBody = '';

  bool _canSave() {
    return _memoTitle.isNotEmpty && _memoBody.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'New Memo',
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
                      widget.memoGroup
                          .addMemo(Memo(title: _memoTitle, body: _memoBody));
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
            onChanged: (value) {
              setState(() {
                _memoTitle = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 30.0)),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onChanged: (value) {
              setState(() {
                _memoBody = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Body',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
