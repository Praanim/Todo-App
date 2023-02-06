import 'package:flutter/material.dart';

const textStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30);

const blacktextStyle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30);

final inputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: Colors.white,
      )),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: Colors.pink,
      )),
);
