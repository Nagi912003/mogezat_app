
import 'package:flutter/material.dart';

Widget myButton(title, onPressed, BuildContext context){
  return MaterialButton(
      onPressed: onPressed,
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.07,
        width: MediaQuery.sizeOf(context).width * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'AeCortoba-wPVz',
              color: Colors.green.shade700,
            ),
          ),
        ),
      ));
}