import 'package:capstone_project/screens/forgot_password_screen.dart';
import '../screens/home_screen.dart';
import '../widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import '../widgets/custom_inkwell_button.dart';
import '../widgets/custom_font.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;

  // ✅ Hardcoded credentials (for now)
  final String correctUsername = "User@gmail.com";
  final String correctPassword = "User1234";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Container(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 60.h),
                Image.asset(
                  'assets/logo/logo.png',
                  height: 80.h,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.image, size: 80.h),
                ),
                SizedBox(height: 80.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomFont(
                    text: 'Login to your Account',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.h),

                // Email
                CustomTextFormField(
                  height: ScreenUtil().setHeight(10),
                  width: ScreenUtil().setWidth(10),
                  controller: emailController,
                  hintText: 'Email',
                  fontSize: 14.sp,
                  hintTextSize: 14.sp,
                  fontColor: Colors.black,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter email';
                    }
                    if (!value.contains('@')) {
                      return 'Enter valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),

                // Password
                CustomTextFormField(
                  height: ScreenUtil().setHeight(10),
                  width: ScreenUtil().setWidth(10),
                  controller: passwordController,
                  isObscure: !_isPasswordVisible,
                  hintText: 'Password',
                  fontSize: 14.sp,
                  hintTextSize: 14.sp,
                  fontColor: Colors.black,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter password' : null,
                  suffixIcon: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: FB_DARK_PRIMARY,
                      size: 20.sp,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),

                // Forgot Password
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PasswordScreen()),
                      );
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12.sp,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),

                // LOGIN BUTTON
                CustomInkwellButton(
                  onTap: () {
                    if (!_formKey.currentState!.validate()) return;

                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    if (email == correctUsername &&
                        password == correctPassword) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid email or password'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  height: 55.h,
                  width: ScreenUtil().screenWidth,
                  buttonName: 'Login',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),

                const Spacer(),

                // Footer
                Padding(
                  padding: EdgeInsets.only(bottom: 30.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style:
                            TextStyle(fontSize: 13.sp, color: Colors.black54),
                            
                      ),
                       GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/register'),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                     
                       Text(
                        "Choose actor ",
                        style:
                            TextStyle(fontSize: 13.sp, color: Colors.black54),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/choose'),
                        child: Text(
                          'Choose actor',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],    
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
