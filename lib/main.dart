import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/storage/shared_pref_helper.dart';
import 'core/storage/key_storage.dart';
import 'modules/auth/login_view.dart';
import 'modules/dashboard/dashboard_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Shared Preferences
  await SharedPrefHelper.init();

  // Lock orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    // Check session
    final isLoggedIn = SharedPrefHelper.getBool(KeyStorage.token) ?? false;

    return MaterialApp(
      title: 'Task Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        fontFamily: 'Inter', // Assuming Inter or a similar sans-serif
      ),
      home: isLoggedIn ? const DashboardView() : const LoginView(),
    );
  }
}
