import 'package:flutter/material.dart';
import 'package:mogezat/providers/mogezat.dart';
import 'package:mogezat/widgets/home_screen/myAppBar.dart';
import 'package:provider/provider.dart';

import '../widgets/azkar_screen/azkar_holder.dart';
import '../widgets/azkar_screen/zekr_holder.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final azkarMorning = Provider.of<Mogezat>(context, listen: false).azkarMorning;
    final azkarNight = Provider.of<Mogezat>(context, listen: false).azkarNight;
    final azkar = Provider.of<Mogezat>(context, listen: false).azkar;
    return Scaffold(
      appBar: myAppBar('أذكار', null),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...azkar.map((e) => Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0),
              child: zekrHolder(e),
            )).toList(),
            AzkarHolder(context,'أذكار الصباح',azkarMorning),
            AzkarHolder(context,'أذكار المساء',azkarNight),
          ],
        ),
      ),
    );
  }
}
