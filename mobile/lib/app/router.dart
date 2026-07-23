import 'package:go_router/go_router.dart';

import '../features/onboarding/presentation/onboarding_page.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const OnboardingPage(),
    ),
  ],
);