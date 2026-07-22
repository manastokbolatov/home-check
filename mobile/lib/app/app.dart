import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../features/onboarding/presentation/onboarding_page.dart';

class HomeCheckApp extends StatelessWidget {
  const HomeCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomeCheck',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
      ),
      textTheme: GoogleFonts.interTextTheme(),
      useMaterial3: true,
      ),
      home: const OnboardingPage(),
    );
  }
}