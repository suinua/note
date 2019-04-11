import 'package:flutter/material.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/providers/memo_group_provider.dart';
import 'package:note/views/model_widgets/memo/main.dart';

class MemoListView extends StatelessWidget {
  const MemoListView();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MemoGroup>(
        stream: MemoGroupBlocProvider.of(context).getValue,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();

          final MemoGroup memoGroup = snapshot.data;
          return ListView.separated(
            itemCount: memoGroup?.children?.memos?.length,
            separatorBuilder: (_, _i) => Divider(),
            itemBuilder: (_, int index) {
              return MemoWidget(memo: memoGroup.children.memos[index]);
            },
          );
        });
  }
}
