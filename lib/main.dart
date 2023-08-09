import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mogezat/providers/mogezat.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'helpers/notification_service.dart';
import 'screens/azkar_screen.dart';
import 'widgets/home_screen/myAppBar.dart';
import 'widgets/home_screen/myBackGround.dart';
import 'widgets/home_screen/myButton.dart';
import 'widgets/home_screen/pageViewWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('box');

  // Initialize FlutterLocalNotificationsPlugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Request notification permission
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();


  tz.initializeTimeZones();
  runApp(const MyApp());

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
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
        'لمحــة\n\nhttps://play.google.com/store/apps/details?id=com.prof_nagi.lam7ah');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('لمحـــة',shareAppLink),
      body: Stack(
        children: [
          myBackGround(context),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 10,
              height: MediaQuery.of(context).size.height - 200,
              child: pageViewWidget(Provider.of<Mogezat>(context).items,
                  _pageController),
            ),
          ),
          Positioned(
            bottom:20,
            width: MediaQuery.sizeOf(context).width ,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                myButton('مشاركة', () {
                  sharePage(Provider.of<Mogezat>(context, listen: false)
                      .items[_pageController.page!.toInt()]);
                }, context),
                // myButton('أذكار الصباح و المساء', () {
                //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AzkarScreen()));
                // }, context),
              ],
            ),
          ),
        ],
      ),
      // drawer: myDrawer(_pageController),
    );
  }
}
