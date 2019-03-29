import 'package:flutter/material.dart';
import 'package:note/models/memo_label.dart';

typedef OnDelete(MemoLabel memoLabel);

class MemoLabelWidget extends StatelessWidget {
  final MemoLabel label;
  final OnDelete onDelete;

  const MemoLabelWidget({Key key, @required this.label, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      onDeleted: onDelete == null ? null : () => onDelete(label),
      label: Text(label.title),
      backgroundColor: label.color,
    );
  }
}
