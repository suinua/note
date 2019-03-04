import 'package:flutter/material.dart';

class Label {
  String key;
  final String title;
  Color color;

  @override
  bool operator ==(o) {
    return o is Label && o.key == o.key;
  }

  Label({@required this.title, @required this.color, this.key});

  factory Label.fromMap(Map<String, dynamic> label) {
    Color _rgboToColor(String rgbo) {
      List<int> values = rgbo.split(',').map(int.parse).toList();
      return Color.fromRGBO(values[0], values[1], values[2], 1);
    }

    Color color = _rgboToColor(label['color']);

    return Label(title: label['title'], color: color);
  }

  Map<String, dynamic> asMap() => {
        'key': key,
        'title': title,
        'color': '${color.red},${color.green},${color.blue}'
      };
}
