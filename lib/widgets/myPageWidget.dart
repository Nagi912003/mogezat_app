
import 'package:flutter/material.dart';

Widget myGradientWidget(BuildContext context,String image, int index, int length) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white,
          Colors.green.shade300,
        ],
      ),
    ),
    child: Image.asset(
      image,
      fit: BoxFit.fitWidth,
    ),
  );
}