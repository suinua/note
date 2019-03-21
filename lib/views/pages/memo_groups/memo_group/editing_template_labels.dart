import 'package:flutter/material.dart';
import 'package:note/blocs/providers/template_memo_labels_bloc_provider.dart';
import 'package:note/models/memo_label.dart';
import 'package:note/views/model_widgets/memo_label.dart';

class EditingTemplateMemoLabelsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
              builder: (_,AsyncSnapshot<List<MemoLabel>> memoLabels){
                if (memoLabels.hasData) {
                  return _buildLabels(memoLabels.data);
                }
                return _buildLabels([]);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLabels(List<MemoLabel> labels) {
    return ListView.builder(
      itemCount: labels.length,
      itemBuilder: (_,int index){
        return MemoLabelWidget(label: labels[index]);
      },
    );
  }
}
