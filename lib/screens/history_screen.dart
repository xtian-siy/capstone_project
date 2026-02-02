import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../widgets/custom_font.dart';


class HistoryItem {
  final String title;
  final DateTime date;
  final bool isApproved;

  HistoryItem({required this.title, required this.date, required this.isApproved});
}

class HistoryScreen extends StatelessWidget {
  final List<HistoryItem> historyList;

  const HistoryScreen({super.key, required this.historyList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), 
      body: Column(
        children: [
          Container(
            height: 70.h,
            width: double.infinity,
            color: const Color(0xFF5D7E97),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  CustomFont(
                    text: "History",
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: historyList.isNotEmpty
                        ? ListView.builder(
                            padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                            itemCount: historyList.length,
                            itemBuilder: (context, index) {
                              return _buildHistoryCard(historyList[index]);
                            },
                          )
                        : const Center(child: Text("No history found")),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(HistoryItem item) {
    String dateStr = DateFormat('MMMM d, y').format(item.date);
    String timeStr = DateFormat('h:mm a').format(item.date);

    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomFont(
            text: "Request ${item.title}",
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          SizedBox(height: 6.h),
          CustomFont(text: dateStr, fontSize: 13.sp, color: Colors.black54),
          CustomFont(text: timeStr, fontSize: 13.sp, color: Colors.black54),
          SizedBox(height: 15.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F3F5),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  item.isApproved ? Icons.check_circle : Icons.cancel,
                  size: 14.sp,
                  color: item.isApproved ? Colors.green : Colors.red,
                ),
                SizedBox(width: 8.w),
                CustomFont(
                  text: item.isApproved ? "Approved" : "Rejected",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}