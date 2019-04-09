import 'package:flutter/material.dart';
import 'package:note/blocs/memo/memos_bloc.dart';
import 'package:note/models/memo.dart';
import 'package:note/providers/memos_bloc_provider.dart';
import 'package:note/views/model_widgets/memo/main.dart';

class MemoListView extends StatelessWidget {
  const MemoListView();

  @override
  Widget build(BuildContext context) {
    final MemosBloc memosBloc = MemosBlocProvider.of(context);

    return StreamBuilder<List<Memo>>(
      stream: memosBloc.getAllMemos,
      builder: (BuildContext context, AsyncSnapshot<List<Memo>> memos) {
        if (memos.hasData) {
          return _buildMemos(memos.data);
        }
        return _buildMemos([]);
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
