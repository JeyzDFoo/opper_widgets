import 'package:opper/data/models/user.dart';
import 'package:opper/data/models/planning_models.dart';

class PlanningChain {
  Block delegateBlock;
  Block milestoneBlock;
  Block resultBlock;
  Block purposeBlock;
  Block objectiveBlock;
  Block entityBlock;

  PlanningChain(
      {required this.delegateBlock,
      required this.milestoneBlock,
      required this.resultBlock,
      required this.purposeBlock,
      required this.objectiveBlock,
      required this.entityBlock});

  Map<String, dynamic> toJson() {
    return {
      'delegateBlock': delegateBlock.toJson(),
      'milestoneBlock': milestoneBlock.toJson(),
      'resultBlock': resultBlock.toJson(),
      'purposeBlock': purposeBlock.toJson(),
      'objectiveBlock': objectiveBlock.toJson(),
      'entityBlock': entityBlock.toJson(),
    };
  }

  PlanningChain.fromJson(Map<String, dynamic> json, OpperUser opperUser)
      : delegateBlock = Block.fromJson(json['delegateBlock'], opperUser),
        milestoneBlock = Block.fromJson(json['milestoneBlock'], opperUser),
        resultBlock = Block.fromJson(json['resultBlock'], opperUser),
        purposeBlock = Block.fromJson(json['purposeBlock'], opperUser),
        objectiveBlock = Block.fromJson(json['objectiveBlock'], opperUser),
        entityBlock = Block.fromJson(json['entityBlock'], opperUser);
}
