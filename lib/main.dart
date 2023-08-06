import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mogezat/providers/mogezat.dart';
import 'package:provider/provider.dart';

import 'helpers/notification_service.dart';

void main() {
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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.green,
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  title: const Text('Flutter Demo Home Page'),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 10,
                  height: MediaQuery.of(context).size.height - 200,
                  child: pageViewWidget(Provider.of<Mogezat>(context)
                      .items), //Image.asset('assets/images/IMG-20230805-WA0009.jpg', fit: BoxFit.fitWidth,),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text('Button 1')),
                    ElevatedButton(onPressed: () {}, child: Text('Button 3')),
                    ElevatedButton(onPressed: () {}, child: Text('Button 4')),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.navigation),
      ),
    );
  }

  Widget pageViewWidget(List items) {
    return PageView.builder(
      controller: PageController(
        initialPage: 0,
      ),
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
}
