import 'package:flutter/material.dart';
import 'package:note/blocs/memo_groups_bloc_provider.dart';
import 'package:note/views/pages/memo_groups/main.dart';

void main() => runApp(MemoGroupsBlocProvider(child: NoteApp()));

class NoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
        ),
        primaryColor: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MemoGroupsPage(),
    );
  }
}
