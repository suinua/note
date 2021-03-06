import 'package:flutter/material.dart';
import 'package:note/providers/memo_groups_bloc_provider.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/views/model_widgets/memo_group/main.dart';
import 'package:note/views/pages/memo_groups/create_memo_group/main.dart';

class MemoGroupsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = MemoGroupsBlocProvider.of(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(Icons.add),
        label: Text('add memo group'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => CreateMemoGroupPage(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(icon: Icon(Icons.account_circle), onPressed: () {}),
                IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Memo Groups',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<MemoGroup>>(
        stream: bloc.getAllGroups,
        builder: (_, AsyncSnapshot<List<MemoGroup>> memoGroups) {
          if (memoGroups.hasData) {
            return _buildGroups(memoGroups.data);
          }
          return _buildGroups([]);
        },
      ),
    );
  }

  Widget _buildGroups(List<MemoGroup> memoGroups) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: memoGroups.length,
      semanticChildCount: 2,
      itemBuilder: (_, int index) {
        return MemoGroupWidget(memoGroup: memoGroups[index]);
      },
    );
  }
}
