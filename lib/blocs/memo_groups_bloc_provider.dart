import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:note/blocs/memo_groups_bloc.dart';

class MemoGroupsBlocProvider extends BlocProvider<MemoGroupsBloc> {
  MemoGroupsBlocProvider({
    @required Widget child,
  }) : super(
    child: child,
    creator: (context, _bag) {
      assert(context != null);
      return MemoGroupsBloc();
    },
  );


  MemoGroupsBlocProvider.fromBlocContext({
    @required BuildContext context,
    @required Widget child,
  }) : super.fromBlocContext(
    child: child,
    context: context,
  );

  static MemoGroupsBloc of(BuildContext context) => BlocProvider.of(context);
}