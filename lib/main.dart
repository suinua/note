import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:note/containers/memo_group_container.dart';
import 'package:note/providers/memo_groups_bloc_provider.dart';
import 'package:note/views/pages/memo_groups/main.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MemoGroupsBlocProvider(
    child: Provider<MemoGroupContainer>(
      value: MemoGroupContainer(),
      child: NoteApp(),
    ),
  ));
}

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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ja', ''),
      ],
      debugShowCheckedModeBanner: false,
      home: MemoGroupsPage(),
    );
  }
}
