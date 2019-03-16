import 'package:flutter/material.dart';
import 'package:note/blocs/memos_bloc_provider.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/views/pages/memo_group_detail/create_memo.dart';
import 'package:note/views/pages/memo_group_detail/memo_list_view.dart';
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
            return MemosBlocProvider.fromBlocContext(
              context: context,
              child: CreateMemoPage(),
            );
          }));
        },
      ),
      body: MemoListView(),
    );
  }
}
