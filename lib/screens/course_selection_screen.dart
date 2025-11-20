import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_course_enrollment_app/providers/enrollment_provider.dart';
import 'package:simple_course_enrollment_app/models/course.dart';

// --- Color Constants (Define these once in a central file, but placed here for convenience) ---
const Color kPrimaryColor = Color(0xFF66E0C2); // Aqua/Teal Background
const Color kAccentColor = Color(0xFF4B0082); // Dark Purple Button/Text
const Color kCardColor = Colors.white; // White for fields/cards

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
        Course(
          id: 'CYBS106',
          name: 'Cybersecurity',
          credits: 3,
          instructor: 'Mr. Ahdzleebee Formentera',
        ),
        Course(
          id: 'TECHNO107',
          name: 'Technopreneurship',
          credits: 3,
          instructor: 'Mr. James Aliazon',
        ),
        Course(
          id: 'DTASTRCT108',
          name: 'Data Structures',
          credits: 3,
          instructor: 'Mr. Leeroy Gadiane',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    // We use context.watch for listening to changes for real-time selection updates
    final provider = context.watch<EnrollmentProvider>();
    final selectedCourse = provider.selectedCourse;

    return Scaffold(
      backgroundColor: kPrimaryColor, // Apply the primary background color
      appBar: AppBar(
        title: const Text(
          'Select a Course',
          style: TextStyle(color: kAccentColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: kPrimaryColor, // Match background for a clean look
        elevation: 0, // Remove shadow
        iconTheme:
            const IconThemeData(color: kAccentColor), // Set back button color
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 10, bottom: 10),
            child: Text(
              'Choose one course to enroll:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: kAccentColor.withOpacity(0.8),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                // Check selection using the full course object or ID for safety
                final isSelected = selectedCourse?.id == course.id;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: InkWell(
                    onTap: () {
                      // Update the global state
                      provider.setCourse(course);
                      // Navigate to the Review screen
                      Navigator.pushNamed(context, '/review');
                    },
                    child: Card(
                      color: kCardColor,
                      elevation:
                          isSelected ? 8 : 2, // Elevated shadow if selected
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color:
                              isSelected ? kAccentColor : Colors.grey.shade300,
                          width: isSelected
                              ? 3.0
                              : 1.0, // Highlight selected course
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  course.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: kAccentColor,
                                  ),
                                ),
                                if (isSelected)
                                  const Icon(
                                    Icons.check_circle,
                                    color: kAccentColor,
                                    size: 24,
                                  ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Code: ${course.id} • ${course.credits} credits',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Instructor: ${course.instructor}',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
