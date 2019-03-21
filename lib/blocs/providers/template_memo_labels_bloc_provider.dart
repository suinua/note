import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:note/blocs/template_memo_labels_bloc.dart';

class TemplateMemoLabelsBlocProvider extends BlocProvider<TemplateMemoLabelsBloc> {
  TemplateMemoLabelsBlocProvider({
    @required String parentGroupKey,
    @required Widget child,
  }) : super(
          child: child,
          creator: (context, _bag) {
            assert(context != null);
            return TemplateMemoLabelsBloc(parentGroupKey);
          },
        );

  TemplateMemoLabelsBlocProvider.fromBlocContext({
    @required BuildContext context,
    @required Widget child,
  }) : super.fromBlocContext(
          child: child,
          context: context,
        );

  static TemplateMemoLabelsBloc of(BuildContext context) =>
      BlocProvider.of(context);
}
