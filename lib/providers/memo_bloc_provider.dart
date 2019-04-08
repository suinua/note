import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:note/blocs/memo/memo_bloc.dart';

class MemoBlocProvider extends BlocProvider<MemoBloc> {
  MemoBlocProvider({
    @required MemoBloc value,
  }) : super(
    creator: (context, _bag) {
      assert(context != null);
      return value;
    },
  );


  MemoBlocProvider.fromBlocContext({
    @required BuildContext context,
    @required Widget child,
  }) : super.fromBlocContext(
    child: child,
    context: context,
  );

  static MemoBloc of(BuildContext context) => BlocProvider.of(context);
}