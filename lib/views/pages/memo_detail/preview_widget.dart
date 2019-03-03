import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:note/models/memo.dart';

class MemoPreviewWidget extends StatelessWidget {
  final Memo memo;

  const MemoPreviewWidget({Key key, @required this.memo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Color.fromRGBO(204, 204, 204, 0.5);

    return Column(
      children: <Widget>[
        Text(
          memo.title,
          style: TextStyle(fontSize: 35),
        ),
        Divider(),
        Expanded(
          child: Markdown(
            data: memo.body,
            styleSheet: MarkdownStyleSheet.fromTheme(
              ThemeData(
                  textTheme: TextTheme(
                display4: TextStyle(fontSize: 11.0 * 2.0),
                display3: TextStyle(fontSize: 56.0 * 2.0),
                display2: TextStyle(fontSize: 45.0 * 2.0),
                display1: TextStyle(fontSize: 34.0 * 2.0),
                headline: TextStyle(
                  fontSize: 24.0 * 2.0,
                  decoration: TextDecoration.underline,
                  decorationColor: color,
                ),
                title: TextStyle(
                  fontSize: 20.0 * 2.0,
                  decoration: TextDecoration.underline,
                  decorationColor: color,
                ),
                subhead: TextStyle(
                  fontSize: 16.0 * 2.0,
                  decoration: TextDecoration.underline,
                  decorationColor: color,
                ),
                body2: TextStyle(
                  fontSize: 14.0 * 2.0,
                  decoration: TextDecoration.underline,
                  decorationColor: color,
                ),
                body1: TextStyle(fontSize: 14.0 * 2.0),
                caption: TextStyle(fontSize: 12.0 * 2.0),
                button: TextStyle(fontSize: 14.0 * 2.0),
                subtitle: TextStyle(fontSize: 14.0 * 2.0),
                overline: TextStyle(fontSize: 10.0 * 2.0),
              )),
            ),
          ),
        ),
      ],
    );
  }
}
