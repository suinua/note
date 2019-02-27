import 'package:flutter/material.dart';
import 'package:note/models/memo.dart';

class MemoDetailPage extends StatelessWidget {
  final Memo memo;

  const MemoDetailPage({Key key, @required this.memo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          memo.title,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white30,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: Text(memo.body),
    );
  }
}