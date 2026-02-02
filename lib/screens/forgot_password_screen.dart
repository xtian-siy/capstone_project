import 'package:capstone_project/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom_textformfield.dart';
import '../constants.dart';
import '../widgets/custom_font.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());

  final TextEditingController _emailController = TextEditingController();

  void _showValidationError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Required'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _verifyOTPEmail() {
    String otp = _otpControllers.map((controller) => controller.text).join();
    String email = _emailController.text.trim();

    if (email.isEmpty && otp.length < 6) {
      _showValidationError("Email and OTP are both required.");
      return;
    }

    if (otp.length < 6) {
      _showValidationError('Please fill in all 6 digits.');
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
      );
    }

    if (email.isEmpty) {
      _showValidationError("Email is required.");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          children: [
            SizedBox(height: 80.h),
            Center(child: Image.asset('assets/logo/logo.png', width: 180.w)),
            SizedBox(height: 60.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Forgot Password',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 8.h),
            Text(
              'Enter your registered email to receive One-Time Password (OTP)',
              style: TextStyle(fontSize: 12.sp, color: Colors.black87),
            ),
            SizedBox(height: 20.h),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  //Input code for email verification
                },
                child: Text('Verify email',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 11.sp)),
              ),
            ),
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Enter OTP',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) => _otpBox(index)),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  //Input code for otp verification from email
                },
                child: Text('Resend code',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 11.sp)),
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF263238),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)),
                ),
                onPressed: _verifyOTPEmail,
                child: Text('Verify',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _otpBox(int index) {
    return Container(
      width: 40.w,
      height: 45.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextField(
        controller: _otpControllers[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (!RegExp(r'^[0-9]$').hasMatch(value)) {
              _otpControllers[index].clear(); 
              _showValidationError('Number only is acceptable on OTP');
            }
          }
        },
        decoration: const InputDecoration(
          counterText: "",
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// --- RESET PASSWORD SCREEN ---
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _conPassController = TextEditingController();

  
  bool _isPasswordVisible = false;

  void _showValidationError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Required'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _handleResetPassword() {
  String newPass = _newPassController.text.trim();
  String conPass = _conPassController.text.trim();

  final complexityRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?":{}|<>]).*$');

  // 1. Check if empty
  if (newPass.isEmpty || conPass.isEmpty) {
    _showValidationError("Please fill in both password fields.");
    return;
  }

  if (newPass.length < 8) {
    _showValidationError("Password must be at least 8 characters long.");
    return;
  }

  if (!complexityRegex.hasMatch(newPass)) {
    _showValidationError("Password must include an uppercase, lowercase, number, and special character.");
    return;
  }

  if (newPass != conPass) {
    _showValidationError("Passwords do not match.");
    return;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Password reset successfully!")),
  );

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const LogInScreen()),
    (route) => false, 
  );
}

  @override
  void dispose() {
    _newPassController.dispose();
    _conPassController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          children: [
            SizedBox(height: 80.h),
            Center(child: Image.asset('assets/logo/logo.png', width: 180.w)),
            SizedBox(height: 60.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Forgot Password',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            ),

            SizedBox(height: 15.h),

            TextField(
              controller: _newPassController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                hintText: 'New Password',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
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
              ),

            SizedBox(height: 20.h),

            TextField(
              controller: _conPassController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
              hintText: 'Confirm Password',
              border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r)),
              contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
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
            ),
           SizedBox(height: 30.h),
           SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
              style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF263238),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r)),
                ),
                
                onPressed: _handleResetPassword, 
                child: Text('Reset Password',
                style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
