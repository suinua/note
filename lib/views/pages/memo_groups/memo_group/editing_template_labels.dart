import 'package:flutter/material.dart';
import 'package:note/blocs/memo_group/template_memo_labels_bloc.dart';
import 'package:note/models/template_memo_label.dart';
import 'package:note/providers/template_memo_labels_bloc_provider.dart';
import 'package:note/views/model_widgets/template_memo_label/main.dart';

class EditingTemplateMemoLabelsPage extends StatefulWidget {
  const EditingTemplateMemoLabelsPage();

  @override
  _EditingTemplateMemoLabelsPageState createState() =>
      _EditingTemplateMemoLabelsPageState();
}

class _EditingTemplateMemoLabelsPageState
    extends State<EditingTemplateMemoLabelsPage> {
  TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TemplateMemoLabelsBloc templateLabelsBloc =
        TemplateMemoLabelsBlocProvider.of(context);

    Widget _buildLabels(BuildContext context, List<TemplateMemoLabel> labels) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: labels.length + 1,
        itemBuilder: (_, int index) {
          if (index == labels.length) {
            return GestureDetector(
              child: Chip(label: Icon(Icons.add)),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return _CreateLabelBottomSheet(
                        titleController: _titleController);
                  },
                );
              },
            );
          }
          return TemplateMemoLabelWidget(label: labels[index]);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close, color: Colors.black),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<List<TemplateMemoLabel>>(
              stream: templateLabelsBloc.getAllLabels,
              builder: (_, AsyncSnapshot<List<TemplateMemoLabel>> memoLabels) {
                if (memoLabels.hasData) {
                  return _buildLabels(context, memoLabels.data);
                }
                return _buildLabels(context, []);
              },
            ),
          )
        ],
      ),
    );
  }
}

class _CreateLabelBottomSheet extends StatelessWidget {
  const _CreateLabelBottomSheet(
      {Key key, @required TextEditingController titleController})
      : _titleController = titleController,
        super(key: key);

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    final TemplateMemoLabelsBloc templateLabelsBloc =
        TemplateMemoLabelsBlocProvider.of(context);

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(child: TextField(controller: _titleController)),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              templateLabelsBloc.addLabel.add(TemplateMemoLabel(
                title: _titleController.text,
                color: Colors.red,
                //TODO : 色を選択できるように
              ));
            },
          )
        ],
      ),
    );
  }
}
