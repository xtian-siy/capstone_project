import 'package:capstone_project/screens/edit_profile_screen.dart';
import 'package:capstone_project/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
  
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 140.h,
                width: double.infinity,
                color: const Color(0xFF5E7A8D),
              ),
              Positioned(
                bottom: -45.h,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(4.r),
                  child: CircleAvatar(
                    radius: 45.r,
                    backgroundColor: const Color(0xFF5E7A8D),
                    child: Icon(
                      Icons.person,
                      size: 60.r,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 55.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Row(
              children: [
                Text("Name: ", style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold)),
                Text("Alyssa Jane Cruz", style: TextStyle(fontSize: 17.sp)),
              ],
            ),
          ),
          const Divider(thickness: 2, height: 1),

      
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Row(
              children: [
                Text("Email: ", style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold)),
                Text("Alyssajc@email.com", style: TextStyle(fontSize: 17.sp)),
              ],
            ),
          ),
          const Divider(thickness: 2, height: 1),

          SizedBox(height: 30.h),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfileScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF233446),
              padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 10.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
              elevation: 4,
            ),
            child: Text("Edit profile", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
          ),

          const Spacer(),

        
          Padding(
            padding: EdgeInsets.only(bottom: 30.h, right: 20.w),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LogInScreen()), 
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF233446),
                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                  elevation: 4,
                ),
                child: Text("Log out", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}