import 'package:cloud_firestore/cloud_firestore.dart';

class MemberData {
  final String memberId;
  final String familyId;
  final String memberName;
  final String memberEmail;
  final String memberPhone;
  final bool isHead;
  final DateTime createdAt;

  MemberData({
    required this.memberId,
    required this.familyId,
    required this.memberName,
    required this.memberEmail,
    required this.memberPhone,
    required this.isHead,
    required this.createdAt,
  });

  factory MemberData.fromMap(String memberId, Map<String, dynamic> map) {
    return MemberData(
      memberId: memberId,
      familyId: map['family_id'] ?? '',
      memberName: map['member_name'] ?? '',
      memberEmail: map['member_email'] ?? '',
      memberPhone: map['member_phone'] ?? '',
      isHead: map['isHead'] ?? false,
      createdAt: (map['createdAt'] as Timestamp).toDate() ?? DateTime.now(),
    );
  }
}