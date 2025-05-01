import 'package:flutter/foundation.dart';
import 'package:opper_submodule/data/models/priority_model.dart';
import 'package:uuid/uuid.dart'; // Import uuid package

class MilestoneModel with ChangeNotifier {
  String? uid;
  String? name;
  String? description;
  List<OpperPriority>? priorities;
  List<String>? parentIds;
  List<String>? childIds;
  List<String>? goalIds;
  bool distributed; // Flag to indicate if the milestone is distributed
  DateTime? distributedDate;
  DateTime? endDate; // Optional end date
  DateTime? startDate; // Optional start date

  // Constructor
  MilestoneModel({
    String? uid,
    this.name,
    this.description,
    this.distributed = false,
    this.distributedDate,
    this.goalIds,
    this.priorities,
    this.parentIds,
    this.childIds,
    this.startDate,
    this.endDate,
  }) : uid = uid ?? Uuid().v4() {
    childIds ??= [];
  }

  // Convert Objective to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'description': description,
      'distributed': distributed,
      'goalIds': goalIds,
      'distributedDate': distributedDate?.toIso8601String(),
      'priorities': priorities?.map((p) => p.toJson()).toList(),
      'parentIds': parentIds,
      'childIds': childIds,
      'startDate': startDate?.toIso8601String(), // Added startDate
      'endDate': endDate?.toIso8601String(), // Added endDate
    };
  }

  // Create Objective from JSON
  factory MilestoneModel.fromJson(Map<String, dynamic> json) {
    return MilestoneModel(
      uid: json['uid'],
      name: json['name'],
      description: json['description'],
      goalIds: (json['goalIds'] as List<dynamic>?)?.cast<String>(),
      distributed: json['distributed'] ?? false,
      distributedDate: json['distributedDate'] != null
          ? DateTime.parse(json['distributedDate'])
          : null,
      priorities: (json['priorities'] as List<dynamic>?)
          ?.map((p) => OpperPriority.fromJson(p))
          .toList(),
      parentIds: (json['parentIds'] as List<dynamic>?)?.cast<String>(),
      childIds: (json['childIds'] as List<dynamic>?)?.cast<String>(),
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate']) // Added startDate parsing
          : null,
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate']) // Added endDate parsing
          : null,
    );
  }
}
