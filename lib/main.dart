import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          //the main page view
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 1.sw,
              height: 0.7.sh,
              child: pageViewWidget(
                  Provider.of<Mogezat>(context).getItems(), _pageController),
            ),
          ),
          //the bottom buttons
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
          //the top bar app name
          Positioned(
            top: 30.h,
            left: 20.w,
            child: Text(
              mogezatData.getAppName(),
              style: TextStyle(
                fontSize: 35.sp / MediaQuery.textScaleFactorOf(context),
                fontFamily: 'AeCortoba-wPVz',
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          //the top bar languages button
          Positioned(
            top: 30.h,
            right: 20.w,
            child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton(
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      mogezatData.getLangsButtonTitle(),
                      style: TextStyle(
                        fontSize: mogezatData.getLangsButtonTitle() ==
                            'languages'
                            ? 20.sp /
                            MediaQuery.textScaleFactorOf(context)
                            : 30.sp /
                            MediaQuery.textScaleFactorOf(context),
                        fontFamily: 'AeCortoba-wPVz',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Icon(
                      Icons.language,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
                iconSize: 40.sp,
                underline: Container(),
                onChanged: (String? value) {
                  mogezatData.setType(value!);
                },
                items: <String>[
                  'العربيــة',
                  'English  عربي',
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
                    child: SizedBox(
                      // width: 100.w,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'AeCortoba-wPVz',
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),),
        ],
      ),
      // drawer: myDrawer(_pageController),
    );
  }
}
