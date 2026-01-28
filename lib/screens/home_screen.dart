import 'package:capstone_project/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import 'request_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required String email});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onTappedBar(int value) {
    setState(() {
      _selectedIndex = value;
    });
    _pageController.jumpToPage(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FB_BACKGROUND_LIGHT,
      body: PageView(
        controller: _pageController,
        onPageChanged: (page) {
          setState(() {
            _selectedIndex = page;
          });
        },
        children: [
          _buildHomeContent(context),
          const Center(child: Text("Pending")),
          const Center(child: Text("History")),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80.h, // Scaled height
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), // Scaled radius
            topRight: Radius.circular(20.r),
          ),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(child: _buildNavigationItem(Icons.home_outlined, Icons.home, 0)),
            Expanded(child: _buildNavigationItem(Icons.access_time, Icons.access_time_filled, 1)),
            Expanded(child: _buildNavigationItem(Icons.assignment_outlined, Icons.assignment, 2)),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationItem(IconData icon, IconData activeIcon, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onTappedBar(index),
      child: Container(
        alignment: Alignment.center,
        height: 80.h, // Adjusted to fit within the bottom bar
        decoration: BoxDecoration(
          color: isSelected ? FB_PRIMARY : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(
          isSelected ? activeIcon : icon,
          color: isSelected ? Colors.white : FB_DARK_PRIMARY,
          size: 28.sp, // Scaled icon size
        ),
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    return Stack(
      children: [
        // Blue Header
        Container(
          height: 300.h, // Scaled header
          width: double.infinity,
          decoration: BoxDecoration(
            color: FB_PRIMARY,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(200.w, 50.h), 
            ),
            image: const DecorationImage(
              image: AssetImage('assets/image/BluePattern.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()), 
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.9),
                    radius: 18.r, // Scaled radius
                    child: Icon(Icons.person, size: 20.sp, color: FB_PRIMARY),
                  ),
                ),
              ),
            ),
          ),
        ),

        Positioned(
          top: 180.h, 
          left: 25.w,
          right: 25.w,
          child: Container(
            height: 150.h, // Scaled height
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10.r,
                  offset: Offset(0, 5.h),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: FB_DARK_PRIMARY.withOpacity(0.1),
                      radius: 15.r,
                      child: Icon(Icons.person, size: 20.sp, color: FB_DARK_PRIMARY),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "Admin",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(Icons.notifications_none, size: 24.sp, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 60.h), 
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: FB_DARK_PRIMARY,
                padding: EdgeInsets.symmetric(horizontal: 45.w, vertical: 15.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r)),
                elevation: 8,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RequestFormScreen()),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("REQUEST",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 30.w),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 20.sp),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}