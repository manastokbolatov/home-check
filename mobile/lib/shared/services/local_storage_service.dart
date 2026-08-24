import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/checklists/models/checklist.dart';
import '../../features/checklists/models/checklist_item.dart';
import '../../features/family/models/family.dart';
import '../../features/family/models/family_member.dart';

class LocalStorageService {
  static const _onboardingKey = 'onboarding_completed';
  static const _checklistsKey = 'checklists';
  static const _userRoleKey = 'user_role';
  static const _familyKey = 'family';

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_onboardingKey, true);
  }

  Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_onboardingKey) ?? false;
  }

  Future<void> saveUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_userRoleKey, role);
  }

  Future<String?> loadUserRole() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_userRoleKey);
  }

  Future<void> saveChecklistState(
    String checklistId,
    List<bool> completed,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final values = completed.map((value) => value ? '1' : '0').toList();

    await prefs.setStringList('checklist_$checklistId', values);
  }

  Future<List<bool>?> loadChecklistState(String checklistId) async {
    final prefs = await SharedPreferences.getInstance();

    final values = prefs.getStringList('checklist_$checklistId');

    if (values == null) {
      return null;
    }

    return values.map((value) => value == '1').toList();
  }

  Future<void> saveChecklists(List<Checklist> checklists) async {
    final prefs = await SharedPreferences.getInstance();

    final data = checklists.map((checklist) {
      return {
        'id': checklist.id,
        'title': checklist.title,
        'assignedChildId': checklist.assignedChildId,
        'items': checklist.items.map((item) {
          return {
            'id': item.id,
            'title': item.title,
            'isCompleted': item.isCompleted,
          };
        }).toList(),
      };
    }).toList();

    await prefs.setString(_checklistsKey, jsonEncode(data));
  }

  Future<List<Checklist>?> loadChecklists() async {
    final prefs = await SharedPreferences.getInstance();

    final value = prefs.getString(_checklistsKey);

    if (value == null) {
      return null;
    }

    final data = jsonDecode(value) as List;

    return data.map((checklist) {
      final map = checklist as Map<String, dynamic>;

      final items = (map['items'] as List).map((item) {
        final itemMap = item as Map<String, dynamic>;

        return ChecklistItem(
          id: itemMap['id'] as String,
          title: itemMap['title'] as String,
          isCompleted: itemMap['isCompleted'] as bool? ?? false,
        );
      }).toList();

      return Checklist(
        id: map['id'] as String,
        title: map['title'] as String,
        items: items,
        assignedChildId: map['assignedChildId'] as String?,
      );
    }).toList();
  }

  Future<void> saveFamily(Family family) async {
    final prefs = await SharedPreferences.getInstance();

    final data = {
      'id': family.id,
      'name': family.name,
      'members': family.members.map((member) {
        return {'id': member.id, 'name': member.name, 'role': member.role};
      }).toList(),
    };

    await prefs.setString(_familyKey, jsonEncode(data));
  }

  Future<Family?> loadFamily() async {
    final prefs = await SharedPreferences.getInstance();

    final value = prefs.getString(_familyKey);

    if (value == null) {
      return null;
    }

    final map = jsonDecode(value) as Map<String, dynamic>;

    final members = (map['members'] as List).map((member) {
      final memberMap = member as Map<String, dynamic>;

      return FamilyMember(
        id: memberMap['id'] as String,
        name: memberMap['name'] as String,
        role: memberMap['role'] as String,
      );
    }).toList();

    return Family(
      id: map['id'] as String,
      name: map['name'] as String,
      members: members,
    );
  }
}
