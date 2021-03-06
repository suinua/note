import 'package:flutter/material.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/models/template_memo_label.dart';
import 'package:note/providers/memo_group_provider.dart';
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
    Widget _buildLabels(List<TemplateMemoLabel> labels) {
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
          StreamBuilder<MemoGroup>(
              stream: MemoGroupBlocProvider.of(context).getValue,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();

                final MemoGroup memoGroup = snapshot.data;
                return Expanded(
                  child: _buildLabels(memoGroup.children.templateMemoLabels),
                );
              })
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
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(child: TextField(controller: _titleController)),
          StreamBuilder<MemoGroup>(
              stream: MemoGroupBlocProvider.of(context).getValue,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();

                final MemoGroup memoGroup = snapshot.data;
                return IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    memoGroup.children.incrementTemplateMemoLabels
                        .add(TemplateMemoLabel(
                      title: _titleController.text,
                      color: Colors.red,
                      //TODO : 色を選択できるように
                    ));
                  },
                );
              })
        ],
      ),
    );
  }
}
