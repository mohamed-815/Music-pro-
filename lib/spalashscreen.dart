import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1stproject/db/allsongstoringclass.dart';
import 'package:flutter_application_1stproject/db/dbfetching.dart';
import 'package:flutter_application_1stproject/funtion.dart';
import 'package:flutter_application_1stproject/mainscreen.dart';
import 'package:flutter_application_1stproject/widjet1/allsongs.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    GotoScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          Color.fromARGB(255, 115, 170, 156),
          Color.fromARGB(255, 27, 40, 37)
        ],
      ),
      body: SafeArea(
          child: Center(
        child: GradientText(
          'MUSIC PRO',
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          colors: const [
            Color.fromARGB(255, 151, 172, 166),
            Color.fromARGB(255, 151, 172, 166),
          ],
        ),
      )),
    );
  }

  Future<void> GotoScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainScreen()));
  }
}
