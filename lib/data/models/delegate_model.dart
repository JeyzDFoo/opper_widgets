import 'package:opper_submodule/data/models/entity_model.dart';
import 'package:opper_submodule/data/models/user.dart';
import 'package:uuid/uuid.dart'; // Added import for Uuid

class DelegateModel {
  String? uuid;
  EntityModel? delegatedTo;
  String? milestoneId;
  OpperUser? delegatedBy;

  DelegateModel({
    this.delegatedTo,
    this.milestoneId,
    this.delegatedBy,
  }) : uuid = Uuid().v4(); // Initialize uuid with Uuid.v4()

  // Convert DelegateModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'delegatedTo': delegatedTo?.toJson(OpperUser(uid: uuid!)),
      'milestoneId': milestoneId,
      'delegatedBy': delegatedBy?.toJson(),
    };
  }

  // Create DelegateModel from JSON
  factory DelegateModel.fromJson(Map<String, dynamic> json) {
    return DelegateModel(
      delegatedTo: json['delegatedTo'] != null
          ? EntityModel.fromJson(json['delegatedTo'])
          : null,
      milestoneId: json['milestoneId'],
      delegatedBy: json['delegatedBy'] != null
          ? OpperUser.fromJson(json['delegatedBy'])
          : null,
    )..uuid = json['uuid'];
  }
}
