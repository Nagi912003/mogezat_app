
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget myButton(title, onPressed, BuildContext context){
  return MaterialButton(
      onPressed: onPressed,
      child: Container(
        height: 0.07.sh,
        width: 0.35.sw,
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
              fontSize: 15.sp  / MediaQuery.textScaleFactorOf(context),
            ),
          ),
        ),
      ));
}