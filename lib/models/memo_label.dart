import 'package:flutter/material.dart';

class MemoLabel {
  String key;
  final String title;
  Color color;

  MemoLabel({@required this.title, @required this.color, this.key});

  factory MemoLabel.fromMap(Map<String, dynamic> label) {
    Color _rgboToColor(String rgbo) {
      List<int> values = rgbo.split(',').map(int.parse).toList();
      return Color.fromRGBO(values[0], values[1], values[2], 1);
    }

    Color color = _rgboToColor(label['color']);

    return MemoLabel(title: label['title'], color: color);
  }

  Map<String, dynamic> asMap() => {
        'key': key,
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
