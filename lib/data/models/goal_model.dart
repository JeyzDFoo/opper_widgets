import 'package:opper_submodule/data/models/delegate_model.dart';
import 'package:opper_submodule/data/models/entity_model.dart';
import 'package:opper_submodule/data/models/member_methods.dart';
import 'package:opper_submodule/data/models/milestone_model.dart';
import 'package:opper_submodule/data/models/objective_model.dart';
import 'package:opper_submodule/data/models/priority_model.dart';
import 'package:opper_submodule/data/models/purpose_model.dart';
import 'package:opper_submodule/data/models/result_model.dart';
import 'package:opper_submodule/data/models/user.dart';
import 'package:opper_submodule/data/priority_methods.dart';
import 'package:uuid/uuid.dart';

class GoalModel {
  String? uid;
  String? name;
  String? description;
  List<EntityModel>? parentEntity;
  List<PurposeModel>? purpose;
  List<ObjectiveModel>? objective;
  List<KeyResultModel>? keyResult;
  List<MilestoneModel>? milestone;
  List<DelegateModel>? delegate;
  List<String>? parentIds;
  List<String>? boardIds;
  List<String>? memberIds;
  List<OpperUser>? members;
  List<Priority>? priorities;
  Priority? priority;

  GoalModel({
    String? uid,
    this.name,
    this.description,
    this.parentEntity,
    this.purpose,
    this.objective,
    this.keyResult,
    this.milestone,
    this.parentIds,
    this.delegate,
    this.boardIds,
    this.memberIds,
    this.members,
    this.priorities,
    this.priority,
  }) : uid = uid ?? Uuid().v4();

  GoalModel.fromJson(Map<String, dynamic> json, OpperUser user)
      : uid = json['uid'],
        name = json['name'],
        description = json['description'],
        parentEntity = json['entity'] != null
            ? (json['entity'] is List
                ? (json['entity'] as List)
                    .map((e) => EntityModel.fromJson(e))
                    .toList()
                : [EntityModel.fromJson(json['entity'])])
            : null,
        purpose = json['purpose'] != null
            ? (json['purpose'] is List
                ? (json['purpose'] as List)
                    .map((p) => PurposeModel.fromJson(p))
                    .toList()
                : [PurposeModel.fromJson(json['purpose'])])
            : null,
        objective = json['objective'] != null
            ? (json['objective'] is List
                ? (json['objective'] as List)
                    .map((o) => ObjectiveModel.fromJson(o))
                    .toList()
                : [ObjectiveModel.fromJson(json['objective'])])
            : null,
        keyResult = json['keyResult'] != null
            ? (json['keyResult'] is List
                ? (json['keyResult'] as List)
                    .map((kr) => KeyResultModel.fromJson(kr, user))
                    .toList()
                : [KeyResultModel.fromJson(json['keyResult'], user)])
            : null,
        milestone = json['milestone'] != null
            ? (json['milestone'] is List
                ? (json['milestone'] as List)
                    .map((m) => MilestoneModel.fromJson(m))
                    .toList()
                : [MilestoneModel.fromJson(json['milestone'])])
            : null,
        delegate = json['delegate'] != null
            ? (json['delegate'] is List
                ? (json['delegate'] as List)
                    .map((d) => DelegateModel.fromJson(d))
                    .toList()
                : [DelegateModel.fromJson(json['delegate'])])
            : null,
        parentIds = (json['parentIds'] as List<dynamic>?)?.cast<String>(),
        boardIds = (json['boardIds'] as List<dynamic>?)?.cast<String>(),
        memberIds = (json['memberIds'] as List<dynamic>?)?.cast<String>(),
        members = mapMembers(json['members']),
        priority = json['priority'] != null
            ? Priority.fromJson(json['priority'])
            : null;

  Map<String, dynamic> toJson(OpperUser user) => {
        'uid': uid,
        'name': name,
        'description': description,
        'entity': parentEntity?.map((e) => e.toJson(user)).toList(),
        'purpose': purpose?.map((p) => p.toJson()).toList(),
        'objective': objective?.map((o) => o.toJson()).toList(),
        'keyResult': keyResult?.map((kr) => kr.toJson()).toList(),
        'milestone': milestone?.map((m) => m.toJson()).toList(),
        'delegate': delegate?.map((d) => d.toJson()).toList(),
        'parentIds': parentIds,
        'boardIds': boardIds,
        'memberIds': cleanMemberIds(memberIds, user),
        'members': cleanMembers(members, user),
        'priorities': updatePriorities(priorities ?? [], priority),
        'priority': priority?.toJson(),
      };
}
