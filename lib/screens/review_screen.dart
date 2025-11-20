import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_course_enrollment_app/providers/enrollment_provider.dart';

// --- Color Constants (Re-defined for clarity) ---
const Color kPrimaryColor = Color(0xFF66E0C2); // Aqua/Teal Background
const Color kAccentColor = Color(0xFF4B0082); // Dark Purple Button/Text
const Color kCardColor = Colors.white; // White for cards

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  // Helper function to build review cards for consistent section styling
  Widget _buildReviewCard(
      {required String title, required List<Widget> children}) {
    return Card(
      color: kCardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 24), // Increased vertical spacing
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kAccentColor, // Use accent color for section titles
              ),
            ),
            const Divider(color: Colors.grey, height: 20),
            ...children,
          ],
        ),
      ),
    );
  }

  // Helper function for individual data rows
  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100, // Fixed width for labels
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: kAccentColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use context.watch<T>() or Provider.of<T>(context)
    final provider = Provider.of<EnrollmentProvider>(context);
    final student = provider.student;
    final course = provider.selectedCourse;

    // --- Error Case (Incomplete Data) ---
    if (student == null || course == null) {
      return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          title: const Text('Review Enrollment',
              style: TextStyle(color: kAccentColor)),
          backgroundColor: kPrimaryColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: kAccentColor),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Text(
              '⚠️ Enrollment information is incomplete. Please go back and fill all details.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.red, fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );
    }

    // --- Review Screen UI ---
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: const Text(
          'Review Enrollment',
          style: TextStyle(color: kAccentColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kAccentColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Please confirm your information before finalizing enrollment.',
                style: TextStyle(fontSize: 16, color: kAccentColor),
              ),
            ),

            // 1. Student Information Card
            _buildReviewCard(
              title: 'Student Information',
              children: [
                _buildDataRow(
                    'Name', '${student.firstName} ${student.lastName}'),
                _buildDataRow('Student ID', student.studentID),
                _buildDataRow('Email', student.email),
              ],
            ),

            // 2. Course Information Card
            _buildReviewCard(
              title: 'Course Information',
              children: [
                _buildDataRow('Course', '${course.name} (${course.id})'),
                _buildDataRow('Instructor', course.instructor),
                _buildDataRow('Credits', course.credits.toString()),
              ],
            ),

            const SizedBox(height: 30),

            // 3. Styled Confirmation Button
            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  // --- Enrollment Logic (Unchanged but styled) ---
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Confirm Enrollment'),
                      content: const Text('Do you want to confirm enrollment?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Confirm'),
                        ),
                      ],
                    ),
                  );

                  if (confirm ?? false) {
                    provider.clear();
                    await showDialog<void>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Enrollment Successful'),
                        content: const Text('You have been enrolled!'),
                        actions: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/student', // Navigate back to the start (Student Form)
                      (route) => false,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAccentColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Confirm Enrollment',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
