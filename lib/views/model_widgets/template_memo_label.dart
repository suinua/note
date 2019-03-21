import 'package:flutter/material.dart';
import 'package:note/models/template_memo_label.dart';

class TemplateMemoLabelWidget extends StatelessWidget {
  final TemplateMemoLabel label;

  const TemplateMemoLabelWidget({Key key, @required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label.title),
      backgroundColor: label.color,
    );
  }
}
