import 'package:flutter/material.dart';

Widget myGradientWidget(
    BuildContext context, String image, int index, int length) {
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
    child: magnifier(Image.asset(
      image,
      fit: BoxFit.fill,
      filterQuality: FilterQuality.high,
    )),
  );
}


Widget magnifier(Widget child){
  return Stack(
    children: [
      InteractiveViewer(
        boundaryMargin: EdgeInsets.all(20),
        child: child,
      ),
      // const Align(
      //   alignment: Alignment.center,
      //   child: RawMagnifier(
      //     size: Size(200, 100),
      //     decoration: MagnifierDecoration(
      //       shape: OutlineInputBorder(
      //         borderSide: BorderSide(color: Colors.deepOrange, width: 2),
      //         borderRadius: BorderRadius.all(
      //           Radius.circular(20),
      //         ),
      //       ),
      //     ),
      //     focalPointOffset: Offset.zero,
      //     magnificationScale: 2,
      //   ),
      // ),
    ],
  );
}
