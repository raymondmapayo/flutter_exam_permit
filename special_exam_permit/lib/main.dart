import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:special_exam_permit/admin/admin_dashboard_page.dart';
import 'package:special_exam_permit/forgot_password.dart';
import 'package:special_exam_permit/login.dart';
import 'package:special_exam_permit/splash/splash_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExamFlow',

      theme: ThemeData(useMaterial3: true),

      initialRoute: '/',

      routes: {
        '/': (context) => const SplashScreen(),
        '/login-page': (context) => const LoginPage(),
        '/admin-dashboard': (context) => const AdminDashboardPage(),
        '/reset-password': (context) => const ForgotPasswordPage(),
      },
    );
  }
}
