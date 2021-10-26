import 'package:d3_season_journey/controller/controller.dart';
import 'package:d3_season_journey/pages/home_page.dart';
import 'package:d3_season_journey/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final ApiService apiService = Get.put(ApiService(), permanent: true);
  final Controller c = Get.put(Controller(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'D3 Journey Tracker',
      theme: ThemeData(
        primaryColor: const Color(0xff2f1111),
        textTheme: const TextTheme(
          headline1: TextStyle(color: Colors.white),
          headline2: TextStyle(color: Colors.white),
          headline3: TextStyle(color: Colors.white),
          headline4: TextStyle(color: Colors.white),
          headline5: TextStyle(color: Colors.white),
          headline6: TextStyle(color: Colors.white),
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
          subtitle1: TextStyle(color: Colors.white),
          subtitle2: TextStyle(color: Colors.white),
          button: TextStyle(color: Colors.white),
          caption: TextStyle(color: Colors.white),
          overline: TextStyle(color: Colors.white),
        ),
        appBarTheme: const AppBarTheme(color: Colors.black),
        scaffoldBackgroundColor: const Color(0xff2f1111),
        unselectedWidgetColor: Colors.white,
        dividerColor: Colors.white,
      ),
      home: const HomePage(),
    );
  }
}
