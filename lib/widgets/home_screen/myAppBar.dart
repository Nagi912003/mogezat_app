import 'package:flutter/material.dart';

AppBar myAppBar(title,onPressed) {
  return AppBar(
    backgroundColor: Colors.transparent,
    title: onPressed!=null? IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.share,
          color: Colors.green.shade700,
        )): null,
    titleSpacing: 10,
    actions: [
      Text(
        title,
        style: TextStyle(
          fontSize: 35,
          fontFamily: 'AeCortoba-wPVz',
          color: Colors.green.shade700,
        ),
      ),
      const SizedBox(
        width: 20,
      )
    ],
  );
}