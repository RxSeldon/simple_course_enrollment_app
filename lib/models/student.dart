class Student {
  final String firstName;
  final String lastName;
  final String email;
  final String studentID;

  Student({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.studentID,
  });

  Student copyWith({
    String? firstName,
    String? lasatName,
    String? email,
    String? studentID,
  }) {
    return Student(
      firstName: firstName ?? this.firstName,
      lastName: lasatName ?? lastName,
      email: email ?? this.email,
      studentID: studentID ?? this.studentID,
    );
  }
}
