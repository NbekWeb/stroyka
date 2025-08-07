import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'pages/splash_page.dart';
import 'pages/auth/index.dart';
import 'pages/timeline/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Stroyka',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => const SplashPage(),
            '/welcome': (context) => const WelcomePage(),
            '/login': (context) => const LoginPage(),
            '/sms-login': (context) => const SmsLoginPage(),
            '/email-login': (context) => const EmailLoginPage(),
            '/': (context) => const HomePage(),
          },
        );
      },
    );
  }
}
