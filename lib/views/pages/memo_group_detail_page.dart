import 'package:flutter/material.dart';
import 'package:note/models/memo.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/views/pages/create_memo_page.dart';
import 'package:note/views/pages/memo_group_setting_page.dart';
import 'package:note/views/widgets/memo_widget.dart';

class MemoGroupDetailPage extends StatelessWidget {
  final MemoGroup memoGroup;

  const MemoGroupDetailPage({Key key, @required this.memoGroup})
      : super(key: key);

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
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        actions: <Widget>[
          Center(
            child: IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return MemoGroupSettingPage(memoGroup: memoGroup);
                    },
                  ),
                );
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
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return CreateMemoBottomSheet(memoGroup: memoGroup);
          }));
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

  Widget _buildMemos(List<Memo> memos) {
    return ListView.builder(
      itemCount: memos.length,
      itemBuilder: (_, int index) {
        return MemoWidget(memo: memos[index]);
      },
    );
  }
}
