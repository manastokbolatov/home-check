import 'package:flutter/widgets.dart';

class OnboardingController {
  final PageController pageController = PageController();

  int currentPage = 0;

  void dispose() {
    pageController.dispose();
  }
}