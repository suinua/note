import 'package:flutter/material.dart';
import 'package:note/blocs/memo_groups_bloc_provider.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/views/widgets/memo_group_widget.dart';

class MemoGroupsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = MemoGroupsBlocProvider.of(context);
    return Column(
      children: <Widget>[
        StreamBuilder<List<MemoGroup>>(
          stream: bloc.getAllGroups,
          initialData: <MemoGroup>[],
          builder: (_, AsyncSnapshot<List<MemoGroup>> memoGroups) {
            return _buildGroups(memoGroups.data);
          },
        ),
      ],
    );
  }

  Widget _buildGroups(List<MemoGroup> memoGroups) {
    return ListView.builder(
      itemCount: memoGroups.length,
      semanticChildCount: 2,
      itemBuilder: (_, int index) {
        return MemoGroupWidget(memoGroup: memoGroups[index]);
      },
    );
  }
}
