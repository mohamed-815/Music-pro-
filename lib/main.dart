import 'package:flutter/material.dart';
import 'package:flutter_application_1stproject/db/allsongstoringclass.dart';
import 'package:flutter_application_1stproject/db/boxinstance.dart';
import 'package:flutter_application_1stproject/db/dbfetching.dart';

import 'package:flutter_application_1stproject/spalashscreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await ScreenUtil.ensureScreenSize();
  Hive.registerAdapter(AllSongsAdapter());
  await Hive.openBox<List>('db_totalsongs');
  await fetchSongs();
  final favoritebox = Boxes.getInstance();
  List<dynamic> favBox = favoritebox.keys.toList();
  if (!favBox.contains("favorite")) {
    List<dynamic> favMusic = [];
    await favoritebox.put("favorite", favMusic);
  }
  if (!favBox.contains("recent1")) {
    List<dynamic> favMusic = [];
    await favoritebox.put("recent1", favMusic);
  }

  favoritesongs = favoritebox.get('favorite');
  final playlistbox = Boxes.getInstance();
  // final pref = await SharedPreferences.getInstance();
  // await pref.setBool('isturnon', false);
  sheredprefenrenceinitial() async {
    final pref3 = await SharedPreferences.getInstance();
    notificationison5 = pref3.getBool('isturnon')!;
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
