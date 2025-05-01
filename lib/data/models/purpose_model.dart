import 'package:flutter/foundation.dart';
import 'package:opper/data/models/priority_model.dart';
import 'package:uuid/uuid.dart'; // Import uuid package

class PurposeModel with ChangeNotifier {
  String? uid;
  String? name;
  String? description;
  List<Priority>? priorities;
  List<String>? parentIds;
  List<String>? childIds;

  // Constructor
  PurposeModel({
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
  factory PurposeModel.fromJson(Map<String, dynamic> json) {
    return PurposeModel(
      uid: json['uid'],
      name: json['name'],
      description: json['description'],
      priorities: (json['priorities'] as List<dynamic>?)
          ?.map((p) => Priority.fromJson(p))
          .toList(),
      parentIds: (json['parentIds'] as List<dynamic>?)?.cast<String>(),
      childIds: (json['childIds'] as List<dynamic>?)?.cast<String>(),
    );
  }
}
