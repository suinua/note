import 'package:flutter/material.dart';
import 'package:note/containers/memo_group_container.dart';
import 'package:note/blocs/template_memo_labels_bloc.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/models/template_memo_label.dart';
import 'package:note/views/model_widgets/template_memo_label.dart';
import 'package:provider/provider.dart';

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
    final MemoGroup memoGroup = Provider.of<MemoGroupContainer>(context).value;
    final bloc = memoGroup.templateMemoLabelsBloc;

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
                        titleController: _titleController, bloc: bloc);
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
              stream: bloc.getAllLabels,
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
  const _CreateLabelBottomSheet({
    Key key,
    @required TextEditingController titleController,
    @required this.bloc,
  })  : _titleController = titleController,
        super(key: key);

  final TextEditingController _titleController;
  final TemplateMemoLabelsBloc bloc;

  @override
  Widget build(BuildContext context) {
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
              bloc.addLabel.add(TemplateMemoLabel(
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
