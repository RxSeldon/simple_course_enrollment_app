import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_course_enrollment_app/providers/enrollment_provider.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EnrollmentProvider>(context);
    final student = provider.student;
    final course = provider.selectedCourse;

    if (student == null || course == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Review Enrollment')),
        body: const Center(
          child: Text(
            'Enrollment information is incomplete. Please go back and fill all details',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Review Enrollment')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Student Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Name: ${student.firstName} ${student.lastName}'),
            Text('Email: ${student.email}'),
            Text('Student ID: ${student.studentID}'),
            const SizedBox(height: 16),
            const Text(
              'Course Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Course: ${course.name}'),
            Text('Instructor: ${course.instructor}'),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () async {
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
                      '/student',
                      (route) => false,
                    );
                  }
                },
                child: const Text('Confirm Enrollment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
