import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/theme/app_spacing.dart';

class OnboardingBottomBar extends StatelessWidget {
  const OnboardingBottomBar({
    super.key,
    required this.isLastPage,
    required this.onNext,
    required this.onSkip,
  });

  final bool isLastPage;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            text: isLastPage
                ? AppLocalizations.of(context)!.getStarted
                : 'Next',
            onPressed: onNext,
          ),
          if (!isLastPage)
            TextButton(
              onPressed: onSkip,
              child: Text(AppLocalizations.of(context)!.skip),
            ),
        ],
      ),
    );
  }
}
