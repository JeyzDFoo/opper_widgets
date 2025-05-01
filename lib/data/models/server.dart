import 'package:uuid/uuid.dart';
import 'user.dart';

class ServerTx {
  String type;
  final OpperUser from;
  final OpperUser to;
  final String? message;
  final DateTime? localTimestamp;
  Map? data;
  final String? id;
  bool isCleared = false;
  bool isDeleted = false;
  final String? status;
  final OpperUser localOpperUser;

  ServerTx({
    this.data,
    required this.to,
    required this.localOpperUser,
    this.message,
    required this.type,
    required this.from,
    this.localTimestamp,
    String? id,
    this.status,
    this.isCleared = false,
    this.isDeleted = false,
  }) : id = id ?? Uuid().v4();

  factory ServerTx.fromJson(
      Map<String, dynamic> json, String id, OpperUser localOpperUser) {
    _parseDate(dynamic date) {
      if (date is DateTime) {
        return date;
      } else if (date != null) {
        return date;
      }
      return null;
    }

    return ServerTx(
        localOpperUser: localOpperUser,
        data: json['data'],
        type: json['type'] ?? 'no_type',
        from: OpperUser.fromJson(json['from']),
        to: OpperUser.fromJson(json['to']),
        localTimestamp: _parseDate(json['localTimestamp']) ?? DateTime.now(),
        message: json['message'],
        isCleared: json['isCleared'] ?? false,
        isDeleted: json['isDeleted'] ?? false,
        status: json['status'],
        id: id);
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'from': from.toJson(),
      'to': to.toJson(),
      'localTimestamp': localTimestamp ?? DateTime.now(),
      'data': data,
      'message': message,
      'id': id,
      'isCleared': isCleared,
      'isDeleted': isDeleted,
      'status': status,
    };
  }
}

enum InviteStatus { created, sent, accepted, rejected, deleted }

class Invite {
  String id;
  String? email;
  String? message;
  DateTime? inviteDate;
  String? inviteStatus;

  Invite({
    required this.id, //should match serverTx id
    this.email,
    this.message,
    this.inviteDate,
    this.inviteStatus,
  });

  factory Invite.fromJson(Map<String, dynamic> json, String id) {
    _parseDate(dynamic date) {
      if (date is DateTime) {
        return date;
      } else if (date != null) {
        return date;
      }
      return null;
    }

    return Invite(
      id: id,
      email: json['email'],
      message: json['message'],
      inviteDate: _parseDate(json['inviteDate']),
      inviteStatus: json['inviteStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'message': message,
      'inviteDate':
          inviteDate?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'inviteStatus': inviteStatus,
    };
  }
}
