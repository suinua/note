import 'package:flutter/material.dart';
import 'package:note/models/label_base.dart';

class TemplateMemoLabel implements LabelBase {
  final String key;
  String title;
  Color color;

  TemplateMemoLabel({@required this.title, @required this.color, this.key});

  @override
  TemplateMemoLabel.fromMap(this.key, Map<String, dynamic> label) {
    assert(key != null);

    Color _rgboToColor(String rgbo) {
      List<int> values = rgbo.split(',').map(int.parse).toList();
      return Color.fromRGBO(values[0], values[1], values[2], 1);
    }

    this.title = label['title'];
    this.color = _rgboToColor(label['color']);
  }

  @override
  Map<String, dynamic> asMap() =>
      {'title': title, 'color': '${color.red},${color.green},${color.blue}'};

  @override
  bool operator ==(o) {
    return o is TemplateMemoLabel && o.key == o.key;
  }

  @override
  int get hashCode => key.hashCode;
}
