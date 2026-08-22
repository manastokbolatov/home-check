import 'package:flutter/material.dart';

import '../models/onboarding_items.dart';
import '../widgets/onboarding_page_content.dart';
import 'onboarding_controller.dart';
import '../widgets/page_indicator.dart';
import '../widgets/onboarding_bottom_bar.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/services/local_storage_service.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingController();
  final storage = LocalStorageService();

  @override
  void initState() {
    super.initState();

    controller.pageController.addListener(() {
      final page = controller.pageController.page?.round() ?? 0;

      if (page != controller.currentPage) {
        setState(() {
          controller.currentPage = page;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: controller.pageController,
            itemCount: onboardingItems.length,
            itemBuilder: (context, index) {
              return OnboardingPageContent(item: onboardingItems[index]);
            },
          ),
        ),

        const SizedBox(height: 24),

        PageIndicator(
          currentPage: controller.currentPage,
          pageCount: onboardingItems.length,
        ),

        const SizedBox(height: 24),

        OnboardingBottomBar(
          isLastPage: controller.currentPage == onboardingItems.length - 1,
          onNext: () async {
            if (controller.currentPage < onboardingItems.length - 1) {
              controller.pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              await storage.completeOnboarding();

              if (context.mounted) {
                context.go('/home');
              }
            }
          },
          onSkip: () {
            controller.pageController.animateToPage(
              onboardingItems.length - 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),

        const SizedBox(height: 32),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
