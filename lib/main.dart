import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasker/app.dart';
import 'package:tasker/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// DI
  await init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const App());
}
