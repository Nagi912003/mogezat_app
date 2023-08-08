import 'package:flutter/material.dart';

Widget zekrHolder(String zekr) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      // borderRadius: BorderRadius.circular(10),
      color: Colors.green[100],
    ),
    child: Text(
      zekr,
      style: const TextStyle(fontSize: 20),
      textAlign: TextAlign.end,
    ),
  );
}