import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:note/blocs/memo/memo_labels_bloc.dart';

class MemoLabelsBlocProvider
    extends BlocProvider<MemoLabelsBloc> {
  MemoLabelsBlocProvider({MemoLabelsBloc value})
      : super(
    creator: (context, _bag) {
      assert(context != null);
      return value;
    },
  );

  MemoLabelsBlocProvider.fromBlocContext({
    @required BuildContext context,
    @required Widget child,
  }) : super.fromBlocContext(
    child: child,
    context: context,
  );

  static MemoLabelsBloc of(BuildContext context) =>
      BlocProvider.of(context);
}
