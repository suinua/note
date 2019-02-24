import 'package:flutter/material.dart';
import 'package:note/blocs/memo_groups_bloc_provider.dart';
import 'package:note/models/memo_group.dart';

class CreateMemoGroupPage extends StatefulWidget {
  @override
  _CreateMemoGroupPageState createState() => _CreateMemoGroupPageState();
}

class _CreateMemoGroupPageState extends State<CreateMemoGroupPage> {
  String _groupTitle = '';
  String _groupDescription = '';

  bool _canSave() {
    return _groupTitle.isNotEmpty && _groupDescription.isNotEmpty;
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
                      //TODO : タップしたらその作ったグループのページに移行
                      bloc.addGroup.add(MemoGroup(
                          title: _groupTitle, description: _groupDescription));
                      Navigator.pop(context);
                    }
                  : null,
              child: Text('save'),
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
                _groupTitle = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            onChanged: (value) {
              setState(() {
                _groupDescription = value;
              });
            },
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
