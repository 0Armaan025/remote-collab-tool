import 'package:flutter/material.dart';

void moveScreen(
    {required BuildContext context,
    required Widget widget,
    bool isPushReplacement = false}) {
  if (isPushReplacement) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => widget));
  } else {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
  }
}
