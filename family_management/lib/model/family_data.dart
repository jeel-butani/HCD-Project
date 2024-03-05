import 'package:cloud_firestore/cloud_firestore.dart';

class FamilyData {
  final String familyId;
  final String familyName;
  final int familySize;
  final String headEmail;
  final String headNum;
  final DateTime createdAt;

  FamilyData({
    required this.familyId,
    required this.familyName,
    required this.familySize,
    required this.headEmail,
    required this.headNum,
    required this.createdAt,
  });

  factory FamilyData.fromMap(String familyId, Map<String, dynamic> map) {
    return FamilyData(
      familyId: familyId,
      familyName: map['family_name'] ?? '',
      familySize: int.parse(map['family_size'] ?? '0'),
      headEmail: map['head_email'] ?? '',
      headNum: map['head_num'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate() ?? DateTime.now(),
    );
  }
}