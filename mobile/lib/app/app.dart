import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

import '../features/onboarding/presentation/onboarding_page.dart';

class HomeCheckApp extends StatelessWidget {
  const HomeCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'HomeCheck',
        debugShowCheckedModeBanner: false,

        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('ru'),

        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            ),
        ),

        home: const OnboardingPage(),
    );
  }
}