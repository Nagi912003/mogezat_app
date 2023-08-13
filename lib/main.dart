import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mogezat/screens/langs_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mogezat/providers/mogezat.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'helpers/notification_service.dart';
import 'widgets/home_screen/myBackGround.dart';
import 'widgets/home_screen/myButton.dart';
import 'widgets/home_screen/pageViewWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('box');
  // Hive.box('box').clear();

  // Initialize FlutterLocalNotificationsPlugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Request notification permission
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();

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
      child: ScreenUtilInit(
          designSize: const Size(411.42857142857144, 914.2857142857143),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
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
            );
          }),
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
    final mogezatData = Provider.of<Mogezat>(context, listen: false);
    return Scaffold(
      // appBar: myAppBar(' ', null),
      body: Stack(
        children: [
          myBackGround(context),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 1.sw,
              height: 0.7.sh,
              child: pageViewWidget(
                  Provider.of<Mogezat>(context).getItems(), _pageController),
            ),
          ),
          Positioned(
            bottom: 20.h,
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                myButton(mogezatData.getShareAppButtonTitle(), () {
                  shareAppLink();
                  // notificationsServices.sendNotification('title', 'body');
                }, context),
                myButton(mogezatData.getSharePhotoButtonTitle(), () {
                  int pageNum = _pageController.page!.toInt();
                  if (pageNum >= 100) {
                    pageNum -= 100;
                  }
                  if (pageNum >= 200) {
                    pageNum -= 200;
                  }
                  if (pageNum >= 300) {
                    pageNum -= 300;
                  }
                  if (pageNum < 0) {
                    pageNum += 100;
                  }

                  while (Provider.of<Mogezat>(context, listen: false)
                          .getItems()
                          .length <
                      pageNum) {
                    pageNum -= Provider.of<Mogezat>(context, listen: false)
                        .getItems()
                        .length;
                  }

                  sharePage(Provider.of<Mogezat>(context, listen: false)
                      .getItems()[pageNum]);
                }, context),
              ],
            ),
          ),
          Positioned(
            top: 25.h,
            child: Container(
              // color: Colors.red,
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    mogezatData.getAppName(),
                    style: TextStyle(
                      fontSize: 35.sp / MediaQuery.textScaleFactorOf(context),
                      fontFamily: 'AeCortoba-wPVz',
                      color: Colors.green.shade700,
                    ),
                  ),
                  SizedBox(
                    width: 110.w,
                  ),
                  DropdownButton(
                    icon: const Icon(
                      Icons.language,
                      color: Colors.green,
                    ),
                    iconSize: 40.sp,
                    underline: Container(),
                    onChanged: (String? value) {
                      mogezatData.setType(value!);
                    },
                    items: <String>[
                      'العربية',
                      'ar_en',
                      'chinese',
                      'english',
                      'french',
                      'german',
                      'italy',
                      'indonesian',
                      'russian',
                      'filipino',
                      'turkish'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'AeCortoba-wPVz',
                            color: Colors.green,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(
                    width: 25,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // drawer: myDrawer(_pageController),
    );
  }
}
