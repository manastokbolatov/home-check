import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

import 'router.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/locale_controller.dart';

import '../core/theme/app_theme.dart';

class HomeCheckApp extends ConsumerWidget {
  const HomeCheckApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeControllerProvider);

    return MaterialApp.router(
      title: 'HomeCheck',
      debugShowCheckedModeBanner: false,

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,

      theme: AppTheme.light(),

      routerConfig: appRouter,
    );
  }
}