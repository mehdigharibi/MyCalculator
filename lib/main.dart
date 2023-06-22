import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prj1/Screens/calc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(Calc());
}
