import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:note/blocs/memo_labels_bloc.dart';

class MemoLabelsBlocProvider extends BlocProvider<MemoLabelsBloc> {
  MemoLabelsBlocProvider({
    @required String parentGroupKey,
    @required String ownerMemoKey,
    @required Widget child,
  }) : super(
          child: child,
          creator: (context, _bag) {
            assert(context != null);
            return MemoLabelsBloc(parentGroupKey,ownerMemoKey);
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
