import 'package:capstone_project/screens/payment_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';

class RequestFormScreen extends StatefulWidget {
  const RequestFormScreen({super.key});

  @override
  State<RequestFormScreen> createState() => _RequestFormScreenState();
}

class _RequestFormScreenState extends State<RequestFormScreen> {
  // 1. Controllers for TextFields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _otherPurposeController = TextEditingController();

  // 2. State variables for Dropdowns
  String? _selectedDoc;
  String? _selectedPurp;

  final List<String> documents = [
    'Transcript of Records',
    'Diploma',
    'Form 137',
    'Good Moral'
  ];

  final List<String> purposes = [
    'Employment',
    'Board Exam',
    'Personal Use',
    'Transfer to another school',
    'Others'
  ];

  final Map<String, double> docPrices = {
    'Transcript of Records': 350.00,
    'Diploma': 200.00,
    'Form 137': 150.00,
    'Good Moral': 100.00,
  };

  @override
  void dispose() {
  
    _nameController.dispose();
    _yearController.dispose();
    _otherPurposeController.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        title: Text(
          "Validation Error",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            color: Colors.redAccent,
          ),
        ),
        content: Text(
          message,
          style: TextStyle(fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              "Okay",
              style: TextStyle(
                color: FB_PRIMARY,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 4. Manual Validation and Submission Logic
  void _validateAndSubmit() {
    String name = _nameController.text.trim();
    String year = _yearController.text.trim();
    String otherPurpose = _otherPurposeController.text.trim();

    if (_selectedDoc == null) {
      _showErrorDialog("Please select a document.");
      return;
    }

    if (name.isEmpty) {
      _showErrorDialog("Full name is required.");
      return;
    }

    if (year.isEmpty) {
      _showErrorDialog("Please provide the School Year or Year Graduated.");
      return;
    }

    if (_selectedPurp == null) {
      _showErrorDialog("Please select the purpose of your request.");
      return;
    }

    if (_selectedPurp == 'Others' && otherPurpose.isEmpty) {
      _showErrorDialog("Please specify your purpose.");
      return;
    }

    // Success: Proceed to Payment Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(
          documentName: _selectedDoc!,
          amount: docPrices[_selectedDoc] ?? 0.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FB_BACKGROUND_LIGHT,
      appBar: AppBar(
        backgroundColor: FB_PRIMARY,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.white, size: 30.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Request Form",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: EdgeInsets.all(30.w),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // Document Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedDoc,
                        hint: const Text("Select Document"),
                        decoration: _inputDecoration(),
                        items: documents
                            .map((doc) => DropdownMenuItem(value: doc, child: Text(doc)))
                            .toList(),
                        onChanged: (val) => setState(() => _selectedDoc = val),
                      ),
                      SizedBox(height: 20.h),

                      // Name Field
                      TextFormField(
                        controller: _nameController,
                        decoration: _inputDecoration(hint: "Full Name"),
                      ),
                      SizedBox(height: 20.h),

                      // Year Field
                      TextFormField(
                        controller: _yearController,
                        key: ValueKey(_selectedDoc),
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration(
                          hint: _selectedDoc != null ? "Year Graduated" : "School Year",
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Purpose Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedPurp,
                        hint: const Text("Select Purpose"),
                        decoration: _inputDecoration(),
                        items: purposes
                            .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                            .toList(),
                        onChanged: (val) => setState(() => _selectedPurp = val),
                      ),

                      // Conditional Others Field
                      if (_selectedPurp == 'Others') ...[
                        SizedBox(height: 20.h),
                        TextFormField(
                          controller: _otherPurposeController,
                          decoration: _inputDecoration(hint: "Please specify purpose"),
                        ),
                      ],

                      const Spacer(),
                      SizedBox(height: 20.h),

                      // Submit Button
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          width: 140.w,
                          height: 45.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: FB_DARK_PRIMARY,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r)),
                            ),
                            onPressed: _validateAndSubmit,
                            child: const Text(
                              "SUBMIT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.r),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.r),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
    );
  }
}