import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAlertDialog(
    BuildContext context,
    String title,
    String description,
    String buttonTitle,
    Function() buttonOnTap,
    ) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(description),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                "Cancel",
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                buttonTitle,
              ),
              onPressed: buttonOnTap
            ),
          ],
        );
      });
}