import 'package:flutter/material.dart';
import 'package:note/blocs/providers/memos_bloc_provider.dart';
import 'package:note/models/memo.dart';
import 'package:note/views/model_widgets/memo.dart';

class MemoListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final memosBloc = MemosBlocProvider.of(context);

    return StreamBuilder<List<Memo>>(
      stream: memosBloc.getAllMemos,
      builder: (BuildContext context, AsyncSnapshot<List<Memo>> memos) {
        if (memos.hasData) {
          return _buildMemos(memos.data);
        } else {
          return _buildMemos([]);
        }
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
