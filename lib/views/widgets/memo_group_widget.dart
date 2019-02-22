import 'package:flutter/material.dart';
import 'package:note/models/memo_group.dart';

class MemoGroupWidget extends StatelessWidget {
  final MemoGroup memoGroup;

  const MemoGroupWidget({Key key, @required this.memoGroup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: 170,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        memoGroup.title,
                        style: TextStyle(fontSize: 28),
                        maxLines: 3,
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  memoGroup.description,
                  style: TextStyle(fontSize: 15,color: Colors.black38),
                  maxLines: 3,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
