import 'package:flutter/material.dart';
import 'package:simple_course_enrollment_app/models/student.dart';
import 'package:simple_course_enrollment_app/models/course.dart';

class EnrollmentProvider extends ChangeNotifier {
  Student? _student;
  Course? _selectedCourse;

  Student? get student => _student;
  Course? get selectedCourse => _selectedCourse;

  void setStudent(Student student) {
    _student = student;
    notifyListeners();
  }

  void setCourse(Course course) {
    _selectedCourse = course;
    notifyListeners();
  }

  void clear() {
    _student = null;
    _selectedCourse = null;
    notifyListeners();
  }

  bool get isComplete => _student != null && _selectedCourse != null;
}
