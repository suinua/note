import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:note/blocs/memo/memos_bloc.dart';

class MemosBlocProvider extends BlocProvider<MemosBloc> {
  MemosBlocProvider({MemosBloc value})
      : super(
          creator: (context, _bag) {
            assert(context != null);
            return value;
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
