import 'package:flutter/material.dart';

Widget myAppBar(onPressed) {
  return AppBar(
    title: IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.share,
          color: Colors.red.shade700,
        )),
    titleSpacing: 0,
    actions: [
      Text(
        'لمحـــة',
        style: TextStyle(
          fontSize: 30,
          fontFamily: 'AeCortoba-wPVz',
          color: Colors.red.shade700,
        ),
      ),
      const SizedBox(
        width: 20,
      )
    ],
  );
}