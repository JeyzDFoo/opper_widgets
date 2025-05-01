import 'package:opper/data/models/user.dart';

mapMembers(List<dynamic>? members) {
  if (members == null) {
    return [];
  }
  return members.map((item) => OpperUser.fromJson(item)).toList();
}

cleanMemberIds(List<String>? memberIds, OpperUser user) {
  if (memberIds == null) {
    memberIds = [];
    memberIds.add(user.uid);
  }

  if (!memberIds.contains(user.uid)) {
    memberIds.add(user.uid);
  }

  return memberIds;
}

cleanMembers(List<OpperUser>? members, OpperUser user) {
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
