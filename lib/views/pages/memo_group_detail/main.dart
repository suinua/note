import 'package:flutter/material.dart';
import 'package:note/models/memo.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/views/model_widgets/memo.dart';
import 'package:note/views/pages/memo_group_detail/create_memo.dart';
import 'package:note/views/pages/memo_group_detail/setting.dart';

class MemoGroupDetailPage extends StatelessWidget {
  //TODO : descriptionを表示する
  final MemoGroup memoGroup;

  const MemoGroupDetailPage({Key key, this.memoGroup}) : super(key: key);

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
            return CreateMemoPage(memoGroup: memoGroup);
          }));
        },
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: StreamBuilder<List<Memo>>(
            stream: memoGroup.getAllMemos,
            builder: (BuildContext context, AsyncSnapshot<List<Memo>> memos) {
              if (memos.hasData) {
                return _buildMemos(context, memos.data);
              } else {
                return _buildMemos(context, []);
              }
            },
          )),
        ],
      ),
    );
  }

  Widget _buildMemos(BuildContext context, List<Memo> memos) {
    return ListView.separated(
      itemCount: memos.length,
      separatorBuilder: (_, int index) => Divider(),
      itemBuilder: (_, int index) {
        return MemoWidget(memo: memos[index]);
      },
    );
  }
}
