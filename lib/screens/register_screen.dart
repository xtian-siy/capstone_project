import '../constants.dart';
import '../widgets/custom_font.dart';
import '../widgets/custom_inkwell_button.dart';
import '../widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
 
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _isPasswordObscure = true;
  bool _isConfirmPasswordObscure = true;

  void _showValidationAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          title: Text("Notice", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
          content: Text(message, style: TextStyle(fontSize: 14.sp)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK", style: TextStyle(color: Color(0xFF233446), fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  void _handleRegister() {
  final email = emailController.text.trim();
  final pass = passwordController.text.trim();
  final confirm = confirmPasswordController.text.trim();

  final complexityRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?":{}|<>]).*$');

  if (email.isEmpty || pass.isEmpty || confirm.isEmpty) {
    _showValidationAlert("All fields are required.");
    return;
  }

  if (pass.length < 8) {
    _showValidationAlert("Password must be at least 8 characters long.");
    return;
  }

  if (!complexityRegex.hasMatch(pass)) {
    _showValidationAlert("Password must include an uppercase, lowercase, number, and special character.");
    return;
  }

  if (pass != confirm) {
    _showValidationAlert("The passwords you entered do not match.");
    return;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Account created successfully!")),
  );

  Navigator.pop(context);
 
}

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
                Image.asset('assets/logo/logo.png', height: 80.h),
                SizedBox(height: 60.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomFont(
                    text: 'Create an Account',
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
                ),
                SizedBox(height: 15.h),

                CustomTextFormField(
                  height: ScreenUtil().setHeight(10),
                  width: ScreenUtil().setWidth(10),
                  controller: passwordController,
                  isObscure: _isPasswordObscure,
                  hintText: 'Password',
                  fontSize: 14.sp,
                  hintTextSize: 14.sp,
                  fontColor: Colors.black,
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordObscure ? Icons.visibility_off : Icons.visibility, size: 20.r),
                    onPressed: () => setState(() => _isPasswordObscure = !_isPasswordObscure),
                  ),
                ),
                SizedBox(height: 15.h),

                CustomTextFormField(
                  height: ScreenUtil().setHeight(10),
                  width: ScreenUtil().setWidth(10),
                  controller: confirmPasswordController,
                  isObscure: _isConfirmPasswordObscure,
                  hintText: 'Confirm Password',
                  fontSize: 14.sp,
                  hintTextSize: 14.sp,
                  fontColor: Colors.black,
                  suffixIcon: IconButton(
                    icon: Icon(_isConfirmPasswordObscure ? Icons.visibility_off : Icons.visibility, size: 20.r),
                    onPressed: () => setState(() => _isConfirmPasswordObscure = !_isConfirmPasswordObscure),
                  ), 
                ),
                SizedBox(height: 30.h),

                CustomInkwellButton(
                  onTap: _handleRegister,
                  height: 55.h,
                  width: ScreenUtil().screenWidth,
                  buttonName: 'Register',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
                
                const Spacer(),
                
                Padding(
                  padding: EdgeInsets.only(bottom: 30.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ", style: TextStyle(fontSize: 13.sp)),
                      GestureDetector(
                       // onTap: () => Navigator.pop(context),
                        child: Text(
                          'Login',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp, color: FB_DARK_PRIMARY),
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