import 'package:flutter/material.dart';
import 'package:note/models/label.dart';

class LabelWidget extends StatelessWidget {
  final Label label;

  const LabelWidget({Key key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label.title),
      backgroundColor: label.color,
    );
  }
}
