import 'package:opper_submodule/data/models/task_model.dart';
import 'package:opper_submodule/data/models/user.dart';

class SurveyModel {
  final String? uuid;
  Task? task;
  final int? responseCount;
  List<String>? emailList;

  SurveyModel({
    this.uuid,
    this.task,
    this.responseCount,
    this.emailList,
  });

  factory SurveyModel.fromJson(Map<String, dynamic> json, OpperUser user) {
    return SurveyModel(
      uuid: json['uuid'],
      task: json['task'] != null ? Task.fromJson(json['task'], user) : null,
      responseCount: json['responseCount'],
      emailList: json['emailList'] != null
          ? List<String>.from(json['emailList'])
          : null,
    );
  }

  Map<String, dynamic> toJson(OpperUser user) {
    return {
      'uuid': uuid,
      'task': task?.toJson(user),
      'responseCount': responseCount,
      'emailList': emailList != null ? List<String>.from(emailList!) : null,
    };
  }
}
