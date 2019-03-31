import 'package:flutter/material.dart';
import 'package:note/blocs/memo_group/memo_group_bloc.dart';
import 'package:note/models/memo_group.dart';
import 'package:note/views/pages/memo_groups/memo_group/main.dart';
import 'package:provider/provider.dart';

class MemoGroupWidget extends StatelessWidget {
  final MemoGroup memoGroup;

  const MemoGroupWidget({Key key, @required this.memoGroup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<MemoGroupBloc>(context).setValue(memoGroup);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) {
            return MemoGroupPage();
          }),
        );
      },
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
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 25),
                        maxLines: 2,
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
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15, color: Colors.black38),
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
