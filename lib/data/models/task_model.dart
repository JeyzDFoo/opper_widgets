import 'package:opper_submodule/data/calculations/time_calcs.dart';
import 'package:opper_submodule/data/models/priority_model.dart';
import 'package:opper_submodule/data/models/recurring.dart';
import 'package:opper_submodule/data/models/user.dart';
import 'package:uuid/uuid.dart';

class Task {
  final String? uuid;
  String title;
  final String? description;
  final DateTime? created;
  DateTime? updated;
  DateTime? completed;
  DateTime? dueDate;
  final GlobalData? globalData;
  final String parentId;
  Priority? priority;
  List<Priority>? priorities;
  bool isComplete;
  bool isCleared;
  bool isDeleted;
  Recurring? recurring;
  List<String>? goalIds;

  Task(
      {required this.title,
      required this.parentId,
      this.priority,
      List<Priority>? priorities,
      this.isCleared = false,
      this.isDeleted = false,
      this.goalIds,
      this.completed,
      this.updated,
      String? uuid,
      this.description,
      this.dueDate,
      this.globalData,
      this.isComplete = false})
      : priorities =
            priorities ?? [], // Initialize priorities to an empty list if null
        uuid = uuid ?? Uuid().v4(), // Assign uuid if not passed
        created = DateTime.now();

  Task.fromJson(Map<String, dynamic> json, OpperUser user)
      : title = json['title'],
        parentId = json['parentId'],
        uuid = json['uuid'],
        completed = _parseDate(json['completed']),
        priority = _getLocalPriority(json['priorities'], user, json['dueDate']),
        priorities = (json['priorities'] == null)
            ? []
            : json['priorities']
                .map<Priority>((e) => Priority.fromJson(e))
                .toList(),
        description = json['description'],
        goalIds = (json['goalIds'] == null)
            ? []
            : json['goalIds'].map<String>((e) => e.toString()).toList(),
        created = _parseDate(json['created']),
        dueDate = _parseDate(json['dueDate']),
        updated = _parseDate(json['updated']),
        globalData = json['globalData'],
        recurring = json['recurring'] != null
            ? Recurring.fromJson(json['recurring'])
            : null,
        isCleared = json['isCleared'] ?? false,
        isDeleted = json['isDeleted'] ?? false,
        isComplete = json['isComplete'];

  Map<String, dynamic> toJson(user) {
    return {
      'title': title,
      'uuid': uuid,
      'description': description,
      'created': created?.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'completed': completed?.toIso8601String(),
      'updated': updated?.toIso8601String(),
      'goalIds': goalIds,
      'globalData': globalData,
      'isComplete': isComplete,
      'parentId': parentId,
      'recurring': recurring?.toJson(),
      'isCleared': isCleared,
      'isDeleted': isDeleted,
      'priorities': _mapLocalPriority(priorities!, priority, user),
    };
  }
}

class GlobalData {
  List<Priority> priorities = [];
}

_getLocalPriority(priorities, OpperUser user, dueDate) {
  if (dueDate != null && dueDate is String) {
    dueDate = DateTime.tryParse(dueDate) ?? DateTime.parse(dueDate);
  }

  Priority localPriority = Priority(user: user);

  if (priorities == null || priorities.isEmpty) {
    print("priorities is null or empty");
    return Priority(user: user);
  }

  priorities = priorities.map((e) => Priority.fromJson(e)).toList();

  localPriority = priorities.firstWhere(
    (element) => element.user.uid == user.uid,
    orElse: () => Priority(user: user),
  );

  if (dueDate != null) {
    try {
      localPriority.urgency = calcUrgencyFromEndDate(dueDate);
    } catch (e) {
      print("Error parsing due date: $e");
    }
  }

  return localPriority;
}

_mapLocalPriority(
    List<Priority> priorities, Priority? priority, OpperUser user) {
  if (priority == null) {
    return priorities.map((e) => e.toJson()).toList();
  }

  bool found = false;
  for (var i = 0; i < priorities.length; i++) {
    if (priorities[i].user.uid == user.uid) {
      priorities[i] = priority;
      found = true;
      break; // Exit loop once the priority is found and updated
    }
  }
  if (!found) {
    priorities.add(priority);
  }

  return priorities.map((e) => e.toJson()).toList();
}

DateTime? _parseDate(dynamic date) {
  if (date == null) return null;
  if (date is String) {
    return DateTime.tryParse(date) ?? DateTime.parse(date);
  } else {
    try {
      return DateTime.fromMillisecondsSinceEpoch(date);
    } catch (e) {
      print("Error parsing date in Task Model: $e");
    }
  }
  throw TypeError(); // Handle unexpected types
}
