import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

import 'router.dart';

class HomeCheckApp extends StatelessWidget {
  const HomeCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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

        routerConfig: appRouter,
    );
  }
}