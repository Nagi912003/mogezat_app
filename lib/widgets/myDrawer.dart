

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Widget myDrawer(PageController _pageController) {
  return Drawer(
    child: ListView.builder(
      itemCount: 18,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('الصفحة رقم: ${(index + 1) * 5}'),
          onTap: () {
            _pageController.jumpToPage(((index + 1) * 5) - 1);
            Navigator.pop(context);
            Hive.box('box').put('pageNum', ((index + 1) * 5) - 1);
          },
        );
      },
    ),
  );
}