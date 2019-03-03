import 'package:flutter/material.dart';

class ConfirmDialog {
  //TODO : on approvedってなんや、、候補「onOk(？？), onAgreement(まぁ、、), onDecided(cancelの可能性もでてくる、、)」
  //Cancel時は何もしない

  static void show(BuildContext context, {@required String title, String body = '',@required Function onApproved}) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            FlatButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            FlatButton(
                child: const Text('OK'),
                onPressed: () {
                  onApproved();
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }
}
