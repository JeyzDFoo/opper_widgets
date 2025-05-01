import 'package:flutter/foundation.dart';
import 'package:opper_submodule/data/models/priority_model.dart';
import 'package:uuid/uuid.dart'; // Import uuid package

class ObjectiveModel with ChangeNotifier {
  String? uid;
  String? name;
  String? description;
  List<OpperPriority>? priorities;
  List<String>? parentIds;
  List<String>? childIds;

  // Constructor
  ObjectiveModel({
    String? uid,
    this.name,
    this.description,
    this.priorities,
    this.parentIds,
    this.childIds,
  }) : uid = uid ?? Uuid().v4() {
    childIds ??= [];
  }

  // Convert Objective to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'description': description,
      'priorities': priorities?.map((p) => p.toJson()).toList(),
      'parentIds': parentIds,
      'childIds': childIds,
    };
  }

  // Create Objective from JSON
  factory ObjectiveModel.fromJson(Map<String, dynamic> json) {
    return ObjectiveModel(
      uid: json['uid'],
      name: json['name'],
      description: json['description'],
      priorities: (json['priorities'] as List<dynamic>?)
          ?.map((p) => OpperPriority.fromJson(p))
          .toList(),
      parentIds: (json['parentIds'] as List<dynamic>?)?.cast<String>(),
      childIds: (json['childIds'] as List<dynamic>?)?.cast<String>(),
    );
  }
}
