import 'package:flutter/material.dart';

void showSnackBar(BuildContext snackBArcontext, String text) {
  ScaffoldMessenger.of(snackBArcontext)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));
}
