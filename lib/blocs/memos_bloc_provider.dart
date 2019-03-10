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

  MemosBlocProvider.fromBlocContext({
    @required BuildContext context,
    @required Widget child,
  }) : super.fromBlocContext(
          child: child,
          context: context,
        );

  static MemosBloc of(BuildContext context) => BlocProvider.of(context);
}
