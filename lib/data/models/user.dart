//.import 'package:cloud_firestore/cloud_firestore.dart';

class OpperUser {
  String uid;
  String? email;
  String? displayName;
  String? timezone;
  DateTime? created;
  DateTime? added;
  DateTime? updated;
  int? tokens;
  bool? completedOnboarding;

  OpperUser({
    required this.uid,
    this.email,
    this.displayName,
    this.timezone,
    this.created,
    this.added,
    this.updated,
    this.tokens,
    this.completedOnboarding,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'timezone': timezone,
      'created': created?.toIso8601String(),
      'added': added?.toIso8601String(),
      'updated': updated?.toIso8601String(),
      'tokens': tokens,
      'completedOnboarding': completedOnboarding,
    };
  }

  factory OpperUser.server() {
    return OpperUser(
      uid: 'server',
      email: 'server',
      tokens: 0,
    );
  }

  factory OpperUser.fromJson(Map<String, dynamic> json) {
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

    return OpperUser(
      uid: json['uid'] ?? 'unknown_id',
      email: json['email'],
      displayName: json['displayName'],
      timezone: json['timezone'],
      created: _parseDate(json['created']) ?? DateTime.now(),
      added: _parseDate(json['added']) ?? DateTime.now(),
      updated: _parseDate(json['updated']) ?? DateTime.now(),
      tokens: json['tokens'],
      completedOnboarding: json['completedOnboarding'],
    );
  }
}
