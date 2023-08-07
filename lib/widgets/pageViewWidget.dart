

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'myPageWidget.dart';

Widget pageViewWidget(List items, PageController? controller) {
  return PageView.builder(
    onPageChanged: (value) {
      Hive.box('box').put('pageNum', value);
    },
    controller: controller,
    scrollDirection: Axis.horizontal,
    reverse: true,
    itemCount: items.length,
    itemBuilder: (context, index) {
      return Stack(
        children: [
          myGradientWidget(context,items[index], index, items.length),
          Align(
            alignment: Alignment.topCenter,
            child: Text('الصفحة رقم: ${index + 1}'),
          ),
        ],
      );
    },
  );
}