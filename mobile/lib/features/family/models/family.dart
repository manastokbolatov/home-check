import 'family_member.dart';

class Family {
  const Family({required this.id, required this.name, required this.members});

  final String id;
  final String name;
  final List<FamilyMember> members;
}
