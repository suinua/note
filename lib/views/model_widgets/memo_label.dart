import 'package:flutter/material.dart';
import 'package:note/models/memo_label.dart';

class MemoLabelWidget extends StatelessWidget {
  final MemoLabel label;

  const MemoLabelWidget({Key key, @required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label.title),
      backgroundColor: label.color,
    );
  }
}
