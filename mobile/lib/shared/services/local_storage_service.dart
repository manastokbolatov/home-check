import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _onboardingKey = 'onboarding_completed';

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  Future<void> saveChecklistState(
    String checklistId,
    List<bool> completed,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final values = completed
        .map((value) => value ? '1' : '0')
        .toList();

    await prefs.setStringList(
      'checklist_$checklistId',
      values,
    );
  }

  Future<List<bool>?> loadChecklistState(
    String checklistId,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final values = prefs.getStringList(
      'checklist_$checklistId',
    );

    if (values == null) {
      return null;
    }

    return values
        .map((value) => value == '1')
        .toList();
  }
}