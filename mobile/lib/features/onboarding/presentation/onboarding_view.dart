import 'package:flutter/material.dart';

import '../models/onboarding_items.dart';
import '../widgets/onboarding_page_content.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: onboardingItems.length,
      itemBuilder: (context, index) {
        return OnboardingPageContent(
          item: onboardingItems[index],
        );
      },
    );
  }
}