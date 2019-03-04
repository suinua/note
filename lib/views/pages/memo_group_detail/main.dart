import 'package:flutter/material.dart';
import 'package:note/models/memo.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/views/confirm_dialog.dart';
import 'package:note/views/model_widgets/memo.dart';
import 'package:note/views/pages/memo_group_detail/create_memo.dart';
import 'package:note/views/pages/memo_group_detail/setting.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
        return Slidable(
          delegate: SlidableDrawerDelegate(),
          actionExtentRatio: 0.25,
          child: MemoWidget(memo: memos[index]),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
                ConfirmDialog.show(
                  context,
                  title: memos[index].title,
                  body: '削除しますか？',
                  onApproved: () {
                    memoGroup.removeMemo(memos[index]);
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
