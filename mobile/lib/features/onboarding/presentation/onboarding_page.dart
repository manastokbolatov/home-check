import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

import '../../../shared/theme/app_spacing.dart';

import '../../../shared/widgets/primary_button.dart';

import '../../../shared/theme/app_text_styles.dart';

import '../../../shared/theme/app_colors.dart';

import '../widgets/check_item.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),

              const Icon(
                Icons.home_rounded,
                size: 110,
                color: AppColors.primary,
              ),

              const SizedBox(height: AppSpacing.xl),

              Text(
                'HomeCheck',
                textAlign: TextAlign.center,
                style: AppTextStyles.displayLarge,
              ),

              const SizedBox(height: AppSpacing.md),

              Text(
                'Check your home before\nleaving with confidence.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLarge,
              ),

              const SizedBox(height: AppSpacing.xxl),

              const CheckItem(
                text: 'Turn off the stove',
              ),

              const CheckItem(
                text: 'Unplug the iron',
              ),

              const CheckItem(
                text: 'Close the windows',
              ),

              const CheckItem(
                text: 'Switch off the lights',
              ),

              const Spacer(),

              PrimaryButton(
                text: AppLocalizations.of(context)!.getStarted,
                onPressed: () {},
              ),

              TextButton(
                onPressed: () {},
                child: Text(
                    AppLocalizations.of(context)!.skip,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}