import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_course_enrollment_app/models/student.dart';
import 'package:simple_course_enrollment_app/providers/enrollment_provider.dart';

// --- Color Constants (Define these once in a central file, but placed here for convenience) ---
const Color kPrimaryColor = Color(0xFF66E0C2); // Aqua/Teal Background
const Color kAccentColor = Color(0xFF4B0082); // Dark Purple Button/Text
const Color kCardColor = Colors.white; // White for fields/cards

class StudentFormScreen extends StatefulWidget {
  const StudentFormScreen({super.key});

  @override
  State<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _studentIDCtrl = TextEditingController();

  // ... (Your existing dispose, validateNotEmpty, and validateEmail methods remain unchanged) ...
  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _studentIDCtrl.dispose();
    super.dispose();
  }

  String? _validateNotEmpty(String? v) {
    if (v == null || v.trim().isEmpty) return 'This field is required';
    return null;
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w.-]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(v.trim())) return 'Enter a valid email';
    return null;
  }
  // ... (End of unchanged methods) ...

  void _next() {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;

    final student = Student(
      firstName: _firstNameCtrl.text.trim(),
      lastName: _lastNameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      studentID: _studentIDCtrl.text.trim(),
    );

    Provider.of<EnrollmentProvider>(context, listen: false).setStudent(student);

    Navigator.pushNamed(context, '/courses');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor, // Apply the primary background color
      appBar: AppBar(
        title: const Text(
          'Student Info',
          style: TextStyle(color: kAccentColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: kPrimaryColor, // Match background for a clean look
        elevation: 0, // Remove shadow
        iconTheme:
            const IconThemeData(color: kAccentColor), // Set back button color
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(24), // Increased padding for better spacing
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 1. Title/Header
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your Details',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: kAccentColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 2. Form Fields using custom style
              _buildCustomTextField(
                controller: _firstNameCtrl,
                labelText: 'First Name',
                validator: _validateNotEmpty,
              ),
              const SizedBox(height: 16),
              _buildCustomTextField(
                controller: _lastNameCtrl,
                labelText: 'Last Name',
                validator: _validateNotEmpty,
              ),
              const SizedBox(height: 16),
              _buildCustomTextField(
                controller: _emailCtrl,
                labelText: 'Email Address',
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildCustomTextField(
                controller: _studentIDCtrl,
                labelText: 'Student ID',
                validator: _validateNotEmpty,
                keyboardType: TextInputType.text,
              ),

              const SizedBox(height: 40),

              // 3. Styled Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kAccentColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                    ),
                  ),
                  child: const Text(
                    'Next: Choose Course',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget for consistent Text Field styling (Reusable component)
  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      style: const TextStyle(color: kAccentColor), // Text input color
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: kAccentColor), // Label color
        filled: true,
        fillColor: kCardColor, // White fill for contrast
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
          borderSide: BorderSide.none, // Remove border for a cleaner look
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: kCardColor, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: kAccentColor, width: 2.0), // Accent focus border
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              const BorderSide(color: Colors.red, width: 2.0), // Error border
        ),
      ),
    );
  }
}
