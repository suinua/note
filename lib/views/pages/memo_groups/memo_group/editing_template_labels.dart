import 'package:flutter/material.dart';
import 'package:note/blocs/template_memo_labels_bloc.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/models/memo_label.dart';
import 'package:note/views/model_widgets/memo_label.dart';

class EditingTemplateMemoLabelsPage extends StatefulWidget {
  final MemoGroup ownerMemoGroup;

  const EditingTemplateMemoLabelsPage({Key key, @required this.ownerMemoGroup}) : super(key: key);

  @override
  _EditingTemplateMemoLabelsPageState createState() =>
      _EditingTemplateMemoLabelsPageState();
}

class _EditingTemplateMemoLabelsPageState
    extends State<EditingTemplateMemoLabelsPage> {
  TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = widget.ownerMemoGroup.templateMemoLabelsBloc;

    Widget _buildLabels(BuildContext context, List<MemoLabel> labels) {
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
          return MemoLabelWidget(label: labels[index]);
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
            child: StreamBuilder<List<MemoLabel>>(
              stream: bloc.getAllLabels,
              builder: (_, AsyncSnapshot<List<MemoLabel>> memoLabels) {
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
              bloc.addLabel.add(MemoLabel(
                title: _titleController.text,
                color: Colors.red,
              ));
            },
          )
        ],
      ),
    );
  }
}