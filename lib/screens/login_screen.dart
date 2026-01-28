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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;

   String correctUsername = "User@gmail.com";
  String correctPassword = "User1234";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                // Logo
                Image.asset(
                  'assets/logo/logo.png', 
                  height: 80.h,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.image, size: 80.h), // Prevents crash if image missing
                ),
                SizedBox(height: 80.h),
                // Title Alignment
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
                
                // Email Field
                CustomTextFormField(
                  height: ScreenUtil().setHeight(10),
                  width: ScreenUtil().setWidth(10),
                  controller: emailController,
                  hintText: 'Email',
                  fontSize: 14.sp,
                  hintTextSize: 14.sp,
                  fontColor: Colors.black,
                  validator: (value) => value!.isEmpty ? 'Enter email' : null,
                  onSaved: (value) => correctUsername = value!,
                ),
                SizedBox(height: 15.h),
                
                // Password Field
                CustomTextFormField(
                  height: ScreenUtil().setHeight(10),
                  width: ScreenUtil().setWidth(10),
                  controller: passwordController,
                  isObscure: false,
                  hintText: 'Password',
                  fontSize: 14.sp,
                  hintTextSize: 14.sp,
                  fontColor: Colors.black,
                  validator: (value) => value!.isEmpty ? 'Enter password' : null,
                  onSaved: (value) => correctPassword = value!,
                  suffixIcon: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
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
                      // Handle forgot password logic
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
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                  email: emailController.text,
                                ),
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
                const Spacer(), // Pushes the following Row to the bottom
                
                // Footer
                Padding(
                  padding: EdgeInsets.only(bottom: 30.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ", 
                        style: TextStyle(fontSize: 13.sp, color: Colors.black54)
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