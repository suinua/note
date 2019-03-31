import 'package:flutter/material.dart';
import 'package:note/blocs/memo_group/memo_group_bloc.dart';
import 'package:note/blocs/memo/memos_bloc.dart';
import 'package:note/models/memo.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/views/model_widgets/memo.dart';
import 'package:provider/provider.dart';

//TODO : rename
class MemoListView extends StatelessWidget {
  const MemoListView();

  @override
  Widget build(BuildContext context) {
    final MemoGroup memoGroup = Provider.of<MemoGroupBloc>(context).value;
    final MemosBloc memosBloc = memoGroup.memosBloc;

    return StreamBuilder<List<Memo>>(
      stream: memosBloc.getAllMemos,
      builder: (BuildContext context, AsyncSnapshot<List<Memo>> memos) {
        if (memos.hasData) {
          return _buildMemos(memos.data);
        }
        return _buildMemos( []);
      },
    );
  }

  Widget _buildMemos(List<Memo> memos) {
    return ListView.separated(
      itemCount: memos.length,
      separatorBuilder: (_, _i) => Divider(),
      itemBuilder: (_, int index) {
        return MemoWidget(memo: memos[index]);
      },
    );
  }
}
