import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:kist/Screens/phoneauth.dart';
import 'package:kist/Screens/splashscreen/splash.dart';
import 'package:kist/Services/Apiconnectservices.dart';
import 'package:kist/Services/firebaseservices.dart';
import 'package:kist/bloc/authbloc/bloc/checklogin_bloc.dart';
import 'package:kist/bloc/loginbloc/login_bloc.dart';
import 'package:kist/cubit/authuserdata/authuserdata_cubit.dart';
import 'package:kist/cubit/category/category_cubit.dart';
import 'package:kist/cubit/logincubit/logincubit_cubit.dart';

final getIt = GetIt.instance;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print('Handling a background message ${message}');
}

void main() async {
  getIt.registerSingleton<ApiConnectService>(ApiConnectService());
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  //firebasepush notification
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
  );
// pushnotification init done
  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('hi', ''),
          Locale('en', ''),
        ],
        path:
            'assets/translation', // <-- change the path of the translation files
        fallbackLocale: Locale('hi', ''),
        child: Blocdefine()),
  );
}

class Blocdefine extends StatelessWidget {
  const Blocdefine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => ApiConnectService(),
          ),
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider(create: (context) => LoginBloc()..add(Logininitial())),
          BlocProvider(
              create: (context) => CheckloginBloc()..add(LoginStatusCheck())),
          BlocProvider(create: (context) => LogincubitCubit()),
          BlocProvider(
              create: (context) => AuthuserdataCubit()..authuserCall()),
          BlocProvider(
              create: (context) => CategoryCubit()..fetchcategorydata())
        ], child: MyApp()));
  }
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
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.red)),
        primarySwatch: Colors.blue,
      ),
    );
  }
}
