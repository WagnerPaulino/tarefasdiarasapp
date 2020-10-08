import 'package:flutter/material.dart';

Future<void> showMyDialog(BuildContext context, Widget title,
    List<Widget> content, List<Widget> actions) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
          title: title,
          content: SingleChildScrollView(
            child: ListBody(children: content),
          ),
          actions: actions);
    },
  );
}
