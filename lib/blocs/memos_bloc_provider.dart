import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:note/blocs/memos_bloc.dart';

class MemosBlocProvider extends BlocProvider<MemosBloc> {
  MemosBlocProvider({
    @required String parentGroupKey,
    @required Widget child,
  }) : super(
          child: child,
          creator: (context, _bag) {
            assert(context != null);
            return MemosBloc(parentGroupKey);
          },
        );

  static MemosBloc of(BuildContext context) => BlocProvider.of(context);
}
