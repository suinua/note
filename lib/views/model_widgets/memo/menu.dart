import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note/models/memo.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/models/memo_label.dart';
import 'package:note/models/template_memo_label.dart';
import 'package:note/providers/memo_group_provider.dart';
import 'package:note/views/model_widgets/memo_label/main.dart';
import 'package:note/views/model_widgets/template_memo_label/main.dart';

enum _MemoMenuTypes {
  MenuList,
  Labels,
  SetLabel,
}

class MemoMenuWidget extends StatefulWidget {
  final Memo memo;

  const MemoMenuWidget({Key key, @required this.memo}) : super(key: key);

  @override
  _MemoMenuWidgetState createState() => _MemoMenuWidgetState();
}

class _MemoMenuWidgetState extends State<MemoMenuWidget> {
  _MemoMenuTypes _memoMenuTypes = _MemoMenuTypes.MenuList;

  void updateMenuType(_MemoMenuTypes type) {
    setState(() {
      _memoMenuTypes = type;
    });
  }

  Widget _menu() {
    switch (_memoMenuTypes) {
      case _MemoMenuTypes.MenuList:
        return _MenuList(
          memo: widget.memo,
          onChangedMenuType: updateMenuType,
        );
      case _MemoMenuTypes.Labels:
        return _Labels(
          memo: widget.memo,
          onChangedMenuType: updateMenuType,
        );
      case _MemoMenuTypes.SetLabel:
        return _SetLabel();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return _menu();
  }
}

/* MenuList */
class _MenuList extends StatelessWidget {
  final Memo memo;
  final void Function(_MemoMenuTypes) onChangedMenuType;

  const _MenuList(
      {Key key, @required this.memo, @required this.onChangedMenuType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text(memo.title),
        ),
        Divider(),
        ListTile(
          title: Text('Labels'),
          leading: const Icon(FontAwesomeIcons.tags, size: 17.0),
          onTap: () => onChangedMenuType(_MemoMenuTypes.Labels),
        ),
      ],
    );
  }
}

/* Labels */

class _Labels extends StatelessWidget {
  final void Function(_MemoMenuTypes) onChangedMenuType;
  final Memo memo;

  const _Labels(
      {Key key, @required this.memo, @required this.onChangedMenuType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      child: _buildLabels(),
    );
  }

  Widget _buildLabels() {
    List<MemoLabel> labels = memo.children.memoLabels;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: labels.length + 1,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, int index) {
        if (index == 0) {
          return IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: () => onChangedMenuType(_MemoMenuTypes.SetLabel),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: MemoLabelWidget(
            label: labels[index - 1],
            onDelete: (label) {
              memo.children.incrementMemoLabels.delete(label);
            },
          ),
        );
      },
    );
  }
}

/* SetLabel */
class _SetLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MemoGroup>(
        stream: MemoGroupBlocProvider.of(context).getValue,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();

          final MemoGroup memoGroup = snapshot.data;
          return Container(
            height: 60.0,
            child: _buildTemplateLabels(memoGroup.children.templateMemoLabels),
          );
        });
  }

  Widget _buildTemplateLabels(List<TemplateMemoLabel> labels) {
    //TODO : 既にMemoについているLabelを削除。
    //TODO : Labelをタップで付与。

    return ListView.builder(
      shrinkWrap: true,
      itemCount: labels.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, int index) {
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: TemplateMemoLabelWidget(label: labels[index]),
        );
      },
    );
  }
}
