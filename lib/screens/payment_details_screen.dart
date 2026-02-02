import 'package:capstone_project/screens/history_screen.dart';
import 'package:capstone_project/screens/home_screen.dart';
import 'package:capstone_project/screens/pending_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import '../widgets/custom_font.dart';

class PaymentScreen extends StatefulWidget {
  final String documentName;
  final double amount;

  const PaymentScreen({
    super.key,
    required this.documentName,
    required this.amount,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: FB_PRIMARY,
        elevation: 4,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: CustomFont(
          text: "Payment Process",
          fontSize: 22.sp,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomFont(
              text: "Preview Details",
              fontSize: 18.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            CustomFont(
              text: "Check your details before confirming the payment.",
              fontSize: 14.sp,
              color: Colors.black54,
            ),

            SizedBox(height: 25.h),
            _buildCard(
              title: "Document Details",
              child: Column(
                children: [
                  _infoRow("Type of Document", widget.documentName),
                  SizedBox(height: 8.h),
                  _infoRow("Amount", "₱ ${widget.amount.toStringAsFixed(2)}"),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            _buildCard(
              title: "Payment Method",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomFont(text: "E-wallet", fontSize: 14.sp, color: Colors.black),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: CustomFont(
                      text: "GCash",
                      fontSize: 14.sp,
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  final now = DateTime.now();

                  

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuccessfulScreen(
                        request: PendingRequest(
                          docName: widget.documentName,
                          dateCreated: now,
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: FB_DARK_PRIMARY,
                  fixedSize: Size(300.w, 50.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                ),
                child: CustomFont(
                  text: "Confirm Payment",
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomFont(text: title, fontSize: 15.sp, color: Colors.black, fontWeight: FontWeight.bold),
          SizedBox(height: 12.h),
          child,
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomFont(text: label, fontSize: 14.sp, color: Colors.black),
        CustomFont(text: value, fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w600),
      ],
    );
  }
}

// ----SUCCESS SCREEN ----

class SuccessfulScreen extends StatelessWidget {
  final PendingRequest request;

  const SuccessfulScreen({
    super.key,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 120.r,
                width: 120.r,
                decoration: const BoxDecoration(
                  color: Color(0xFF9DB2BF),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 80.r,
                ),
              ),

              SizedBox(height: 30.h),

              CustomFont(
                text: "Payment Successful",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),

              SizedBox(height: 50.h),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(
                        initialIndex: 1,
                        newRequest: request,
                      ),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF27374D),
                  fixedSize: Size(340.w, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  elevation: 5,
                ),
                child: CustomFont(
                  text: "Ok",
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

