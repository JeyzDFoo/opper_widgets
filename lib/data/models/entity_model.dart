import 'package:opper/data/models/member_methods.dart';
import 'package:uuid/uuid.dart';
import 'package:opper/data/models/user.dart';

class EntityModel {
  String? uid;
  String? displayName;
  String? timezone;
  DateTime? created;
  DateTime? added;
  DateTime? updated;
  bool? completedOnboarding;
  List<OpperUser>? members;
  List<String>? memberIds;
  String? notes;
  String? originId;
  List<String>? childIds;

  EntityModel({
    String? uid,
    this.members,
    this.displayName,
    this.timezone,
    this.created,
    this.added,
    this.updated,
    this.notes,
    this.completedOnboarding,
    this.memberIds,
    this.originId,
    this.childIds,
  }) : uid = uid ?? const Uuid().v4() {
    childIds ??= [];
  }

  Map<String, dynamic> toJson(OpperUser user) {
    return {
      'uid': uid,
      'displayName': displayName,
      'timezone': timezone,
      'created': created?.toIso8601String(),
      'added': added?.toIso8601String(),
      'updated': updated?.toIso8601String(),
      'completedOnboarding': completedOnboarding,
      'members': cleanMembers(members, user),
      'memberIds': cleanMemberIds(memberIds, user),
      'notes': notes,
      'originId': originId,
      'childrenIds': childIds,
    };
  }

  factory EntityModel.server() {
    return EntityModel(
      uid: 'server',
    );
  }

  factory EntityModel.fromJson(Map<String, dynamic> json) {
    DateTime? _parseDate(dynamic date) {
      if (date is DateTime) {
        return date;
      } else if (date is String) {
        return DateTime.parse(date);
      } else if (date != null) {
        return null;
        // return (date as Timestamp).toDateTime();
      }
      return null;
    }

    return EntityModel(
      uid: json['uid'] ?? 'unknown_id',
      displayName: json['displayName'],
      timezone: json['timezone'],
      created: _parseDate(json['created']) ?? DateTime.now(),
      added: _parseDate(json['added']) ?? DateTime.now(),
      updated: _parseDate(json['updated']) ?? DateTime.now(),
      completedOnboarding: json['completedOnboarding'],
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => OpperUser.fromJson(e))
          .toList(),
      memberIds: (json['memberIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      notes: json['notes'],
      originId: json['originId'],
      childIds: (json['childrenIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }
}
