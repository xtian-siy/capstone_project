import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;
  final picker = ImagePicker();

  final TextEditingController _nameController = TextEditingController(text: "Alyssa Cruz");
  final TextEditingController _emailController = TextEditingController(text: "Alyjane@email.com");
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool _obscurePass = true;
  bool _obscureConfirm = true;

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  void _showValidationAlert(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        title: Text("Notice", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
        content: Text(message, style: TextStyle(fontSize: 14.sp)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK", style: TextStyle(color: Color(0xFF233446), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _handleSave() {
 
  final pass = _passController.text.trim();
  final confirm = _confirmPassController.text.trim();

  final complexityRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?":{}|<>]).*$');

  if (pass.isEmpty || confirm.isEmpty) {
    _showValidationAlert("Password fields cannot be left empty.");
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
      const SnackBar(content: Text("Profile updated successfully!")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Edit Profile", style: TextStyle(color: Colors.white, fontSize: 18.sp)),
        backgroundColor: const Color(0xFF1E1E1E),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 55.h),
            _buildImagePickerButton(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Name:"),
                  _buildTextField(_nameController),
                  SizedBox(height: 15.h),
                  _buildLabel("Email:"),
                  _buildTextField(_emailController),
                  SizedBox(height: 15.h),
                  _buildLabel("Change password"),
                  _buildPasswordField(_passController, _obscurePass, () {
                    setState(() => _obscurePass = !_obscurePass);
                  }),
                  SizedBox(height: 15.h),
                  _buildLabel("Confirm Password"),
                  _buildPasswordField(_confirmPassController, _obscureConfirm, () {
                    setState(() => _obscureConfirm = !_obscureConfirm);
                  }),
                  SizedBox(height: 40.h),
                  _buildSaveButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(height: 120.h, width: double.infinity, color: const Color(0xFF5E7A8D)),
        Positioned(
          bottom: -45.h,
          child: Container(
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            padding: EdgeInsets.all(4.r),
            child: CircleAvatar(
              radius: 45.r,
              backgroundColor: const Color(0xFF5E7A8D),
              backgroundImage: _image != null ? FileImage(_image!) : null,
              child: _image == null ? Icon(Icons.person, size: 60.r, color: Colors.black) : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePickerButton() {
    return ElevatedButton(
      onPressed: _pickImage,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF233446),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      ),
      child: const Text("Change Profile", style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildSaveButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _handleSave,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF233446),
          fixedSize: Size(250.w, 45.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        ),
        child: Text("Save Changes", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Text(text, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r)),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, bool obscure, VoidCallback onToggle) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r)),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility, size: 20.r),
          onPressed: onToggle,
        ),
      ),
    );
  }
}