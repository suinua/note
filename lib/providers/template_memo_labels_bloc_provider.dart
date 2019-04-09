import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:note/blocs/memo_group/template_memo_labels_bloc.dart';

class TemplateMemoLabelsBlocProvider
    extends BlocProvider<TemplateMemoLabelsBloc> {
  TemplateMemoLabelsBlocProvider({TemplateMemoLabelsBloc value})
      : super(
          creator: (context, _bag) {
            assert(context != null);
            return value;
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
