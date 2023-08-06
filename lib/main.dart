import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mogezat/providers/mogezat.dart';

import 'helpers/notification_service.dart';

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

  @override
  void initState() {
    notificationsServices.initialiseNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.green.shade400,
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                myAppBar(),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 10,
                  height: MediaQuery.of(context).size.height - 200,
                  child: pageViewWidget(Provider.of<Mogezat>(context)
                      .items), //Image.asset('assets/images/IMG-20230805-WA0009.jpg', fit: BoxFit.fitWidth,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(
                            width: 1.0,
                            color: Colors.red.shade700,
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'مشاركة',
                          style: TextStyle(
                            fontFamily: 'AeCortoba-wPVz',
                            color: Colors.red.shade700,
                          ),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(
                            width: 1.0,
                            color: Colors.red.shade700,
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'أذكار الصباح و المساء',
                          style: TextStyle(
                            fontFamily: 'AeCortoba-wPVz',
                            color: Colors.red.shade700,
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: 18,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('الصفحة لقم: ${(index + 1) * 5}'),
              onTap: () {
                _pageController.jumpToPage(((index + 1) * 5) - 1);
                Navigator.pop(context);
                Hive.box('box').put('pageNum', ((index + 1) * 5) - 1);
              },
            );
          },
        ),
      ),
    );
  }

  Widget pageViewWidget(List items) {
    return PageView.builder(
      onPageChanged: (value) {
        Hive.box('box').put('pageNum', value);
      },
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      reverse: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            myGradientWidget(items[index], index, items.length),
            Align(
              alignment: Alignment.topCenter,
              child: Text('الصفحة رقم: ${index + 1}'),
            ),
          ],
        );
      },
    );
  }

  Widget myGradientWidget(String image, int index, int length) {
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

  Widget myAppBar() {
    return AppBar(
      title: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.share,
            color: Colors.red.shade700,
          )),
      titleSpacing: 0,
      actions: [
        Text(
          'لمحـــة',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'AeCortoba-wPVz',
            color: Colors.red.shade700,
          ),
        ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }
}
