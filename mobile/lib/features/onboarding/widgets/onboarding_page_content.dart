import 'package:flutter/material.dart';

import '../../../shared/theme/app_spacing.dart';
import '../../../shared/theme/app_text_styles.dart';

import '../models/onboarding_item.dart';
import '../../../shared/theme/app_colors.dart';

class OnboardingPageContent extends StatelessWidget {
  const OnboardingPageContent({super.key, required this.item});

  final OnboardingItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(item.icon, size: 110, color: AppColors.primary),

          const SizedBox(height: AppSpacing.xl),

          Text(
            item.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.displayLarge,
          ),

          const SizedBox(height: AppSpacing.md),

          Text(
            item.description,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge,
          ),
        ],
      ),
    );
  }
}
