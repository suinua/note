import 'package:flutter/material.dart';
import 'package:note/models/memo.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/views/widgets/memo_widget.dart';

class MemoGroupPage extends StatelessWidget {
  final MemoGroup memoGroup;

  const MemoGroupPage({Key key, @required this.memoGroup}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          memoGroup.title,
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
            child: IconButton(
              icon: const Icon(Icons.settings,color: Colors.grey,),
              onPressed: () {
                //TODO : 設定画面に飛ぶ
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(Icons.add),
        label: Text('add memo'),
        onPressed: () {
          //TODO : 追加用のBottomSheetを表示
        },
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _buildMemos(memoGroup.getAllMemos),
          ),
        ],
      ),
    );
  }

  Widget _buildMemos(List<Memo> memos){
    return ListView.builder(
      itemCount: memos.length,
      itemBuilder: (_,int index){
        return MemoWidget(memo: memos[index]);
      },
    );
  }
}