import 'package:flutter/material.dart';
import 'package:note/models/template_memo_label.dart';

typedef OnDelete(TemplateMemoLabel label);

class TemplateMemoLabelWidget extends StatelessWidget {
  final TemplateMemoLabel label;
  final OnDelete onDelete;

  const TemplateMemoLabelWidget({Key key, @required this.label, this.onDelete})
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
