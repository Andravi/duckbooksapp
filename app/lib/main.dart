import 'package:app/configs/app_settings.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'configs/hive_config.dart';

import 'flutter_flow_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();
  await Firebase.initializeApp();
  await FlutterFlowTheme.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppSettings(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthService(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = FlutterFlowTheme.themeMode;


    return MaterialApp(
      title: 'DuckBooks App',
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: themeMode,
      home: const LoginPage(),
    );
    // return DynamicColorBuilder(
    //   builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
    //     ColorScheme lightScheme;
    //     ColorScheme darkScheme;

    //     if (lightDynamic != null && darkDynamic != null) {
    //       lightScheme = lightDynamic.harmonized();
    //       lightCustomColors = lightCustomColors.harmonized(lightScheme);

    //       // Repeat for the dark color scheme.
    //       darkScheme = darkDynamic.harmonized();
    //       darkCustomColors = darkCustomColors.harmonized(darkScheme);
    //     } else {
    //       // Otherwise, use fallback schemes.
    //       lightScheme = lightColorScheme;
    //       darkScheme = darkColorScheme;
    //     }

    //     return MaterialApp(
    //       theme: ThemeData(
    //         useMaterial3: true,
    //         colorScheme: lightScheme,
    //         extensions: [lightCustomColors],
    //       ),
    //       darkTheme: ThemeData(
    //         useMaterial3: true,
    //         colorScheme: darkScheme,
    //         extensions: [darkCustomColors],
    //       ),
    //
    //     );
    //   },
    // );
  }
}