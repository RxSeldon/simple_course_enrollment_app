import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_course_enrollment_app/providers/enrollment_provider.dart';

const Color kPrimaryColor = Color(0xFF66E0C2);
const Color kAccentColor = Color(0xFF4B0082);
const Color kCardColor = Colors.white;

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  Widget _buildReviewCard(
      {required String title, required List<Widget> children}) {
    return Card(
      color: kCardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kAccentColor,
              ),
            ),
            const Divider(color: Colors.grey, height: 20),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: kAccentColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EnrollmentProvider>(context);
    final student = provider.student;
    final course = provider.selectedCourse;

    if (student == null || course == null) {
      return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          title: Text(
            'Review Enrollment',
            style: TextStyle(color: kAccentColor),
          ),
          backgroundColor: kPrimaryColor,
          elevation: 0,
          iconTheme: IconThemeData(color: kAccentColor),
        ),
        body: Center(
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

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: Text(
          'Review Enrollment',
          style: TextStyle(color: kAccentColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: kAccentColor),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Logo at the top ---
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),

            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Please confirm your information before finalizing enrollment.',
                style: TextStyle(fontSize: 16, color: kAccentColor),
                textAlign: TextAlign.center,
              ),
            ),

            // Student Information
            _buildReviewCard(
              title: 'Student Information',
              children: [
                _buildDataRow(
                    'Name', '${student.firstName} ${student.lastName}'),
                _buildDataRow('Student ID', student.studentID),
                _buildDataRow('Email', student.email),
              ],
            ),

            // Course Information
            _buildReviewCard(
              title: 'Course Information',
              children: [
                _buildDataRow('Course', '${course.name} (${course.id})'),
                _buildDataRow('Instructor', course.instructor),
                _buildDataRow('Credits', course.credits.toString()),
              ],
            ),

            SizedBox(height: 30),

            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Confirm Enrollment'),
                      content: Text('Do you want to confirm enrollment?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text('Confirm'),
                        ),
                      ],
                    ),
                  );

                  if (confirm ?? false) {
                    await showDialog<void>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Enrollment Successful'),
                        content: Text('You have been enrolled!'),
                        actions: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/student',
                      (route) => false,
                    );

                    Future.microtask(() {
                      provider.clear();
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAccentColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
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
