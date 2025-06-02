import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simanpro_v03/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint = (String? message, {int? wrapWidth}) {
    if (message != null && message.contains('Frame')) return;
    debugPrintThrottled(message, wrapWidth: wrapWidth);
  };
  runApp(const ProjectManagementApp());
}

class ProjectManagementApp extends StatelessWidget {
  const ProjectManagementApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KonstruksiPro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const SplashScreen(),
    );
  }
}
