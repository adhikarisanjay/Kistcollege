import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kist/Screens/splashscreen/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('hi', ''),
          Locale('en', ''),
        ],
        path:
            'assets/translation', // <-- change the path of the translation files
        fallbackLocale: Locale('hi', ''),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: "Kist test project",
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.red)),
        primarySwatch: Colors.blue,
      ),
    );
  }
}
