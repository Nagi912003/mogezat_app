import 'package:flutter/material.dart';
import 'package:mogezat/providers/mogezat.dart';
import 'package:mogezat/widgets/home_screen/myAppBar.dart';
import 'package:provider/provider.dart';

import '../widgets/azkar_screen/azkar_holder.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final azkarMorning = Provider.of<Mogezat>(context, listen: false).azkarMorning;
    final azkarNight = Provider.of<Mogezat>(context, listen: false).azkarNight;
    return Scaffold(
      appBar: myAppBar('أذكار', null),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AzkarHolder(context,'أذكار الصباح',azkarMorning),
            AzkarHolder(context,'أذكار المساء',azkarNight),
          ],
        ),
      ),
    );
  }
}
