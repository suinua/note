import 'package:flutter/material.dart';
import 'package:note/blocs/memos_bloc.dart';
import 'package:note/models/memo.dart';
import 'package:note/views/model_widgets/memo.dart';

//TODO : rename
class MemoListView extends StatelessWidget {
  final MemosBloc memosBloc;

  const MemoListView({Key key, @required this.memosBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Memo>>(
      stream: memosBloc.getAllMemos,
      builder: (BuildContext context, AsyncSnapshot<List<Memo>> memos) {
        if (memos.hasData) {
          return _buildMemos(context, memos.data);
        } else {
          return _buildMemos(context, []);
        }
      },
    );
  }

  Widget _buildMemos(BuildContext context, List<Memo> memos) {
    return ListView.separated(
      itemCount: memos.length,
      separatorBuilder: (_, _i) => Divider(),
      itemBuilder: (_, int index) {
        return MemoWidget(
          memo: memos[index],
          onChanged: (Memo memo) {
            memosBloc.updateMemo.add(memo);
          },
          onRemoved: (Memo memo) {
            memosBloc.removeMemo.add(memo);
          },
        );
      },
    );
  }
}
