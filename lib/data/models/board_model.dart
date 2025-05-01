import 'package:opper_submodule/data/models/user.dart';
import 'package:opper_submodule/design/pallet_colors.dart';
import 'package:uuid/uuid.dart';

class Board {
  final String? uuid;

  String? name;
  String? description;
  final String? parentId;
  List<String>? memberIds;
  List<OpperUser>? members;
  PalletColor? color;

  Board(
      {String? uuid,
      this.name,
      this.description,
      this.parentId,
      this.color,
      this.members,
      this.memberIds})
      : uuid = uuid ?? Uuid().v4();

  Board.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        name = json['name'],
        description = json['description'],
        parentId = json['parentId'],
        color = PalletColors().getPalletColorByIndex(json['color'] ?? 0),
        memberIds = List<String>.from(json['memberIds'] ?? []),
        members = _mapMembers(json['members']);

  Map<String, dynamic> toJson(OpperUser user) => {
        'uuid': uuid,
        'name': name,
        'description': description,
        'parentId': parentId,
        'color': color?.colorIndex,
        'memberIds': _cleanMemberIds(memberIds, user),
        'members': _cleanMembers(members, user),
      };
}

_mapMembers(List<dynamic>? members) {
  if (members == null) {
    return [];
  }
  return members.map((item) => OpperUser.fromJson(item)).toList();
}

_cleanMemberIds(List<String>? memberIds, OpperUser user) {
  if (memberIds == null) {
    memberIds = [];
    memberIds.add(user.uid);
  }

  if (!memberIds.contains(user.uid)) {
    memberIds.add(user.uid);
  }

  return memberIds;
}

_cleanMembers(List<OpperUser>? members, OpperUser user) {
  List<OpperUser> membersList = members ?? [];
  if (members == null) {
    members = [];
    membersList.add(user);
  } else {
    bool found = false;
    List<OpperUser> tempMembersList = [];
    for (var member in members) {
      if (member.uid == user.uid) {
        found = true;
      }
      tempMembersList.add(member);
    }
    if (!found) {
      tempMembersList.add(user);
    }
    membersList = tempMembersList;
  }

  // map members to json
  List<Map<String, dynamic>> membersJson = [];
  for (var member in membersList) {
    membersJson.add(member.toJson());
  }

  return membersJson;
}
