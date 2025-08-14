import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/firebase_options.dart';
import 'package:evently_app/provider/user_provider.dart';
import 'package:evently_app/screens/intro/introduction_screens.dart';
import 'package:evently_app/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/add_event/add_event_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/register/login_screen.dart';
import 'screens/register/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: ChangeNotifierProvider(
          create: (context) => UserProvider(),
          child: const MyApp(),
        )),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return MaterialApp(
        theme: AppTheme.Light,
        darkTheme: AppTheme.Dark,
        themeMode: ThemeMode.light,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        initialRoute: userProvider.firebaseUser != null
            ? HomeScreen.routeName
            : IntroductionScreens.routeName,
        routes: {
          IntroductionScreens.routeName: (context) =>
              const IntroductionScreens(),
          HomeScreen.routeName: (context) => HomeScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          SignupScreen.routeName: (context) => SignupScreen(),
          AddEventScreen.routeName: (context) => AddEventScreen(),
        });
  }
}
