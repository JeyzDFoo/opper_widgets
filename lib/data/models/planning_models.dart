import 'package:opper_submodule/data/models/priority_model.dart';
import 'package:opper_submodule/data/models/user.dart';
import 'package:opper_submodule/data/priority_methods.dart';
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

enum BlockType {
  entity,
  strategy,
  purpose,
  objective,
  keyResult,
  milestone,
  delegate,
  hub,
  task,
}

class Block {
  List<String> memberIds = [];
  List<OpperUser>? members = [];
  List<String> parentIds = [];
  List<String> childIds = [];
  List<double> values = [];
  String? name;
  String? notes;
  final BlockType type;
  final String? uuid;
  final OpperUser originator;
  final OpperUser localUser;
  OpperPriority? priority;
  List<OpperPriority>? priorities;
  int blockNumber;
  String? hash;
  String? previousHash;
  Map<String, dynamic>? data = {};

  Block(
      {required this.originator,
      this.name,
      required this.childIds,
      required this.localUser,
      required this.type,
      required this.parentIds,
      this.priority,
      this.priorities,
      this.previousHash,
      this.blockNumber = 0,
      this.data,
      String? uuid,
      this.notes,
      this.members})
      : uuid = uuid ?? Uuid().v4();

  Map<String, dynamic> toJson({bool forHashing = false}) {
    memberIds = _checkMembersIds();
    members = _formatMembers();

    final json = {
      'type': type.toString(),
      'name': name,
      'notes': notes,
      'uuid': uuid,
      'memberIds': memberIds,
      'members': members?.map((e) => e.toJson()).toList(),
      'parentIds': parentIds,
      'values': values,
      'originator': originator.toJson(),
      'blockNumber': blockNumber, //iterate when writing
      'previousHash': previousHash, //hash of previous block
      'data': data,
      'childIds': childIds,
      'priorities': updatePriorities(priorities, priority),
    };
    if (!forHashing) {
      json['hash'] = hashBlock(); //hash of this block
    }
    return json;
  }

  factory Block.fromJson(Map<String, dynamic> json, OpperUser localUser) {
    List<OpperPriority> _priorities = json['priorities'] != null
        ? List<OpperPriority>.from(
            json['priorities'].map((e) => OpperPriority.fromJson(e)))
        : [];

    return Block(
      localUser: localUser,
      priority: getLocalPriority(_priorities, localUser),
      name: json['name'],
      notes: json['notes'],
      type: BlockType.values.firstWhere((e) => e.toString() == json['type']),
      uuid: json['uuid'],
      members: json['members'] != null
          ? List<OpperUser>.from(
              json['members'].map((e) => OpperUser.fromJson(e)))
          : [],
      originator: json['originator'] != null
          ? OpperUser.fromJson(json['originator'])
          : OpperUser(uid: "no_id"),
      parentIds:
          json['parentIds'] != null ? List<String>.from(json['parentIds']) : [],
      previousHash: json['hash'],
      blockNumber: json['blockNumber'] ?? 0,
      data: json['data'],
      childIds:
          json['childIds'] != null ? List<String>.from(json['childIds']) : [],
    )
      ..memberIds.addAll(List<String>.from(json['memberIds']))
      ..parentIds.addAll(List<String>.from(json['parentIds']))
      ..values.addAll(List<double>.from(json['values']));
  }

  String hashBlock() {
    var bytes = utf8.encode(jsonEncode(toJson(forHashing: true)));
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  List<String> _checkMembersIds() {
    if (!memberIds.contains(localUser.uid)) {
      memberIds.add(localUser.uid);
    }
    return memberIds;
  }

  List<OpperUser> _formatMembers() {
    if (members == null) {
      members = [];
    }

    if (!members!.contains(localUser)) {
      members!.add(localUser);
    }
    return members!;
  }
}
