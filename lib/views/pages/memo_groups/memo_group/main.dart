import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note/blocs/memo_group/memo_group_bloc.dart';
import 'package:note/providers/memo_groups_bloc_provider.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/views/confirm_dialog.dart';
import 'package:note/views/pages/memo_groups/memo_group/create_memo/main.dart';
import 'package:note/views/pages/memo_groups/memo_group/editing.dart';
import 'package:note/views/pages/memo_groups/memo_group/editing_template_labels.dart';
import 'package:note/views/pages/memo_groups/memo_group/memo_list_view.dart';
import 'package:provider/provider.dart';

class MemoGroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MemoGroup memoGroup = Provider.of<MemoGroupBloc>(context).value;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          memoGroup.title,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(Icons.add),
        label: Text('add memo'),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CreateMemoPage(),
              ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (_) {
                        return _GroupSettingMenu();
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: MemoListView(),
    );
  }
}

class _GroupSettingMenu extends StatelessWidget {
  const _GroupSettingMenu();

  @override
  Widget build(BuildContext context) {
    final MemoGroup memoGroup = Provider.of<MemoGroupBloc>(context).value;
    final memoGroupsBloc = MemoGroupsBlocProvider.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Divider(),
        ListTile(
          title: const Text('Labels'),
          leading: const Icon(FontAwesomeIcons.tags, size: 17.0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditingTemplateMemoLabelsPage(),
              ),
            );
          },
        ),
        ListTile(
          title: const Text('Remove'),
          leading: const Icon(Icons.delete),
          onTap: () {
            ConfirmDialog.show(
              context,
              title: memoGroup.title,
              body: 'Remove it?',
              onApproved: () {
                memoGroupsBloc.removeGroup.add(memoGroup);
                Navigator.pop(context);
              },
            );
          },
        ),
        Divider(),
        ListTile(
          title: const Text('Title'),
          leading: const Icon(Icons.edit),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    EditingMemoGroupTitlePage(defaultTitle: memoGroup.title),
              ),
            ).then((title) {
              if (title != null) {
                memoGroup.title = title;
                memoGroupsBloc.updateGroup.add(memoGroup);
              }
            });
          },
        ),
        ListTile(
          title: const Text('Description'),
          leading: const Icon(Icons.edit),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditingMemoGroupDescriptionPage(
                    defaultDescription: memoGroup.description),
              ),
            ).then((description) {
              if (description != null) {
                memoGroup.description = description;
                memoGroupsBloc.updateGroup.add(memoGroup);
              }
            });
          },
        ),
      ],
    );
  }
}
