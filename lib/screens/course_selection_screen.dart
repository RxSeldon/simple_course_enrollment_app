import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_course_enrollment_app/providers/enrollment_provider.dart';
import 'package:simple_course_enrollment_app/models/course.dart';

class CourseSelectionScreen extends StatelessWidget {
  const CourseSelectionScreen({super.key});

  List<Course> get courses => [
    Course(
      id: 'CSE101',
      name: 'Introduction to Progamming',
      credits: 3,
      instructor: 'Mr. Gene Abello',
    ),
    Course(
      id: 'MOB102',
      name: 'Mobile Development',
      credits: 3,
      instructor: 'Mr. Ahdzleebee Formentera',
    ),
    Course(
      id: 'WEB103',
      name: 'Web Development',
      credits: 3,
      instructor: 'Mr. Roderick Bandalan',
    ),
    Course(
      id: 'SFTENG104',
      name: 'Software Engineering',
      credits: 3,
      instructor: 'Ms. Josephine Petralba',
    ),
    Course(
      id: 'NET105',
      name: 'Networking',
      credits: 3,
      instructor: 'Mr. Vicente Patalita III',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EnrollmentProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Select a course')),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          final selected = provider.selectedCourse?.id == course.id;

          return Card(
            child: ListTile(
              title: Text(course.name),
              subtitle: Text(
                '${course.credits} credits • ${course.instructor}',
              ),
              trailing: selected ? const Icon(Icons.check_circle) : null,
              onTap: () {
                provider.setCourse(course);
                Navigator.pushNamed(context, '/review');
              },
            ),
          );
        },
      ),
    );
  }
}
