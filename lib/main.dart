import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EnrollmentProvider(),
      child: MaterialApp(
        title: 'Course Enrollment',
        theme: ThemeData(primarySwatch: Colors.indigo),
        initialRoute: '/',
        routes: {
          '/': (_) => const IntroScreen(),
          '/student': (_) => const StudentFormScreen(),
          '/courses': (_) => const CourseSelectionScreen(),
          '/review': (_) => const ReviewScreen(),
        },
      ),
    );
  }
}
