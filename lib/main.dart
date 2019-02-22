import 'package:flutter/material.dart';
import 'package:note/blocs/memo_groups_bloc_provider.dart';
import 'package:note/views/pages/page_memo_groups.dart';

void main() => runApp(MemoGroupsBlocProvider(child: NoteApp()));

class NoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MemoGroupsPage(),
      ),
    );
  }
}
