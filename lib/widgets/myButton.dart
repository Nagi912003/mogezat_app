
import 'package:flutter/material.dart';

Widget myButton(title, onPressed){
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          width: 1.0,
          color: Colors.red.shade700,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'AeCortoba-wPVz',
          color: Colors.red.shade700,
        ),
      ));
}