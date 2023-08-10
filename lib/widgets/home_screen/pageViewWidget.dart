

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'myPageWidget.dart';

Widget pageViewWidget(List items, PageController? controller) {
  return Listener(
    child: PageView.builder(
      onPageChanged: (index) {
        Hive.box('box').put('pageNum', index);
        if (index < items.length || index >= items.length * 2) {
          // Scroll to the corresponding page in the middle
          int targetPage = index % items.length + items.length;
          controller!.jumpToPage(targetPage);
        }
      },
      controller: controller,
      scrollDirection: Axis.horizontal,
      reverse: true,
      itemCount: items.length * 3,
      // itemBuilder: (context, index) {
      //   final itemIndex = index % items.length;
      //   return Center(
      //     child: Text(items[itemIndex]),
      //   );
      // },
      itemBuilder: (context, index) {
        final itemIndex = index % items.length;
        return Container(
          margin: const EdgeInsets.all(7),
          child: myGradientWidget(context,items[itemIndex], index, items.length),
        );
      },
    ),
  );
}

//
// import 'package:flutter/material.dart';
//
// class CircularPageView extends StatefulWidget {
//   @override
//   _CircularPageViewState createState() => _CircularPageViewState();
// }
//
// class _CircularPageViewState extends State<CircularPageView> {
//   late PageController _pageController;
//   List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
//
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(
//       initialPage: items.length,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PageView.builder(
//       controller: _pageController,
//       reverse: true,
//       itemCount: items.length * 3, // Triple the length for circular effect
//       itemBuilder: (context, index) {
//         final itemIndex = index % items.length;
//         return Center(
//           child: Text(items[itemIndex]),
//         );
//       },
//       onPageChanged: (int index) {
//         if (index < items.length || index >= items.length * 2) {
//           // Scroll to the corresponding page in the middle
//           int targetPage = index % items.length + items.length;
//           _pageController.jumpToPage(targetPage);
//         }
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
// }
//
// void main() {
//   runApp(MaterialApp(home: CircularPageView()));
// }
//