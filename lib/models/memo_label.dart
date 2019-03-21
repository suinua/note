import 'package:flutter/material.dart';

class MemoLabel {
  String key;
  String title;
  Color color;

  MemoLabel({@required this.title, @required this.color, this.key});

  MemoLabel.fromMap(this.key, Map<String, dynamic> label) {
    Color _rgboToColor(String rgbo) {
      List<int> values = rgbo.split(',').map(int.parse).toList();
      return Color.fromRGBO(values[0], values[1], values[2], 1);
    }

    this.title = label['title'];
    this.color = _rgboToColor(label['color']);
  }

  Map<String, dynamic> asMap() => {
        'title': title,
        'color': '${color.red},${color.green},${color.blue}'
      };

  @override
  bool operator ==(o) {
    return o is MemoLabel && o.key == o.key;
  }

  @override
  int get hashCode => key.hashCode;
}
