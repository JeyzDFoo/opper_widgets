import 'package:flutter/foundation.dart';
import 'package:opper_submodule/data/models/priority_model.dart';
import 'package:opper_submodule/data/models/user.dart';
import 'package:opper_submodule/data/priority_methods.dart';
import 'package:uuid/uuid.dart'; // Import uuid package

class KeyResultModel with ChangeNotifier {
  // Renamed class
  String? uid;
  String? name;
  String? description;
  Priority? priority;
  List<Priority>? priorities;
  List<String>? parentIds;
  List<String>? childIds;
  DateTime? endDate; // Optional end date
  DateTime? startDate; // Optional start date

  // Constructor
  KeyResultModel({
    // Updated constructor name
    String? uid,
    this.priority,
    this.name,
    this.description,
    this.priorities,
    this.parentIds,
    this.childIds,
    this.startDate,
    this.endDate,
  }) : uid = uid ?? Uuid().v4() {
    childIds ??= [];
  } // Assign uid if null

  // Convert KeyResult to JSON
  Map<String, dynamic> toJson() {
    priorities = updatePriorities(priorities ?? [], priority);

    return {
      'uid': uid,
      'name': name,
      'description': description,
      'priorities': priorities?.map((p) => p.toJson()).toList(),
      'parentIds': parentIds,
      'childIds': childIds,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
    };
  }

  // Create KeyResult from JSON
  factory KeyResultModel.fromJson(
      Map<String, dynamic> json, OpperUser localUser) {
    return KeyResultModel(
      // Updated constructor call
      uid: json['uid'],
      name: json['name'],
      description: json['description'],
      priority: getLocalPriority(
        (json['priorities'] as List<dynamic>?)
                ?.map((p) => Priority.fromJson(p))
                .toList() ??
            [],
        localUser,
      ),
      priorities: (json['priorities'] as List<dynamic>?)
          ?.map((p) => Priority.fromJson(p))
          .toList(),
      parentIds: (json['parentIds'] as List<dynamic>?)?.cast<String>(),
      childIds: (json['childIds'] as List<dynamic>?)?.cast<String>(),
      startDate:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
    );
  }
}
