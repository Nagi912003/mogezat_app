

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Widget myDrawer(PageController _pageController) {
  return Drawer(
    child: ListView.builder(
      itemCount: 94,
      itemBuilder: (context, index) {
        return ListTile(
          trailing: Text('الصفحة رقم: ${(index + 1)}', style: TextStyle(fontSize: 20),),
          onTap: () {
            _pageController.jumpToPage((index));
            Navigator.pop(context);
            Hive.box('box').put('pageNum', index);
          },
        );
      },
    ),
  );
}