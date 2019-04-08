import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:note/blocs/memo_group/memo_group_bloc.dart';

class MemoGroupBlocProvider extends BlocProvider<MemoGroupBloc> {
  MemoGroupBlocProvider({
    @required MemoGroupBloc value,
  }) : super(
          creator: (context, _bag) {
            assert(context != null);
            return value;
          },
        );

  MemoGroupBlocProvider.fromBlocContext({
    @required BuildContext context,
    @required Widget child,
  }) : super.fromBlocContext(
          child: child,
          context: context,
        );

  static MemoGroupBloc of(BuildContext context) => BlocProvider.of(context);
}
