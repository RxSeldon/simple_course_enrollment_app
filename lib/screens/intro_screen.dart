import 'package:flutter/material.dart';

// --- Color Constants (Define these in a separate file like 'constants.dart' for best practice) ---
const Color kPrimaryColor = Color(0xFF66E0C2); // Aqua/Teal Background
const Color kAccentColor = Color(0xFF4B0082); // Dark Purple Button/Text
const Color kTextColor = Color(0xFF1A1A1A); // Dark Text

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // Remove the AppBar to achieve the full-screen welcome look
      backgroundColor: kPrimaryColor, // Set the background color
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. Logo/Icon Placeholder (Replace with your actual EduNova logo/icon)
              Image.asset(
                'assets/images/logo.png', // **ASSUME you have an asset here**
                height: screenHeight * 0.25,
              ),
              const SizedBox(height: 16),
              const Text(
                'WELCOME!', // Branding Text
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: kAccentColor,
                ),
              ),
              const SizedBox(height: 50),
              // 2. Main Title - Welcome
              const Text(
                'Simple Course Enrollment App',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: kAccentColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              // 3. Subtitle/Description
              const Text(
                'Enroll in your next course. Fast, Simple, Done!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: kAccentColor,
                ),
              ),
              const SizedBox(height: 60),
              // 4. Styled Button
              SizedBox(
                width: 200, // Fixed width for the 'Get Started' button
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/student'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kAccentColor, // Dark Purple
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          30), // High radius for pill shape
                    ),
                  ),
                  child: const Text(
                    'Get Started',
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
}
