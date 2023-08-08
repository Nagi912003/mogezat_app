
import 'package:flutter/material.dart';

Widget myButton(title, onPressed){
  return MaterialButton(
      onPressed: onPressed,
      child: Container(
        height: 60,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'AeCortoba-wPVz',
              color: Colors.green.shade700,
            ),
          ),
        ),
      ));
}