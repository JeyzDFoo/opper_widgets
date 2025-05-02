import 'package:opper_submodule/data/models/task_model.dart';
import 'package:opper_submodule/data/models/user.dart';

class SurveyModel {
  final String? uuid;
  Task? task;
  final int? responseCount;
  final DateTime? timeout;

  SurveyModel({
    this.uuid,
    this.task,
    this.responseCount,
    this.timeout,
  });

  factory SurveyModel.fromJson(Map<String, dynamic> json, OpperUser user) {
    return SurveyModel(
      uuid: json['uuid'],
      task: json['task'] != null ? Task.fromJson(json['task'], user) : null,
      responseCount: json['responseCount'],
      timeout: json['timeout'] != null ? DateTime.parse(json['timeout']) : null,
    );
  }

  Map<String, dynamic> toJson(OpperUser user) {
    return {
      'uuid': uuid,
      'task': task?.toJson(user),
      'responseCount': responseCount,
      'timeout': timeout?.toIso8601String(),
    };
  }
}
