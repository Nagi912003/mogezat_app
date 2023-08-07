import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mogezat/providers/mogezat.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import 'helpers/notification_service.dart';
import 'widgets/myAppBar.dart';
import 'widgets/myBackGround.dart';
import 'widgets/myButton.dart';
import 'widgets/myDrawer.dart';
import 'widgets/pageViewWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Mogezat(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          // brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green,
            primaryColorDark: Colors.green[700],
            accentColor: Colors.yellow[800],
            backgroundColor: Colors.green[50],
            cardColor: Colors.green[50],
            errorColor: Colors.redAccent,
            brightness: Brightness.light,
          ),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NotificationsServices notificationsServices = NotificationsServices();
  final PageController _pageController = PageController(
      initialPage: Hive.box('box').get('pageNum', defaultValue: 0));
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    notificationsServices.initialiseNotifications();
    super.initState();
  }

  void sharePage(String image) async {
    var takenWidget = Image.asset(image);
    await screenshotController
        .captureFromWidget(
      // pixelRatio: pixelRatio,
      InheritedTheme.captureAll(context, Material(child: takenWidget)),
      // delay: const Duration(seconds: 1),
    )
        .then((image) async {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/image.png').create();
      await imagePath.writeAsBytes(image);

      /// Share Plugin
      await Share.shareFiles([imagePath.path], text: '#لمحــة \n #صل_على_محمد');
      // ShowCapturedWidget(context, image);
    });
  }

  void shareAppLink() async {
    await Share.share(
        'لمحــة\n\nhttps://play.google.com/store/apps/details?id=com.prof_nagi.ahadith');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          myBackGround(context),
          SingleChildScrollView(
            child: Column(
              children: [
                myAppBar(shareAppLink),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 10,
                  height: MediaQuery.of(context).size.height - 200,
                  child: pageViewWidget(Provider.of<Mogezat>(context).items,
                      _pageController), //Image.asset('assets/images/IMG-20230805-WA0009.jpg', fit: BoxFit.fitWidth,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    myButton('مشاركة', () {
                      sharePage(Provider.of<Mogezat>(context, listen: false)
                          .items[_pageController.page!.toInt()]);
                    }),
                    myButton('أذكار الصباح و المساء', () {

                    }),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      drawer: myDrawer(_pageController),
    );
  }
}
