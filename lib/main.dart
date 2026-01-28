import 'package:capstone_project/screens/profile_screen.dart';

import '../screens/home_screen.dart';
import '../screens/request_form_screen.dart';
import '../screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/login_screen.dart';


void main() => runApp(const Verifitor());

class Verifitor extends StatelessWidget {
  const Verifitor({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 715),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Verifitor App',
          // Change initialRoute to login
          initialRoute: '/login', 
          routes: {
            '/login': (context) => const LogInScreen(),
            '/register': (context) => const RegisterScreen(),
            '/home': (context) => const HomeScreen(email: '',),
            '/form': (context) => const RequestFormScreen(),
            '/profile': (context) => const ProfileScreen(),

          },
        );
      },
    );
  }
}
