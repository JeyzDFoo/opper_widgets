import 'package:opper_submodule/data/models/priority_model.dart';
import 'package:opper_submodule/data/models/user.dart';

updatePriorities(List<OpperPriority>? priorities, OpperPriority? priority) {
  if (priorities == null) {
    priorities = [];
  }
  if (priority != null) {
    priorities.add(priority);
  }
  return priorities;
}

OpperPriority? getLocalPriority(
    List<OpperPriority> priorities, OpperUser localUser) {
  for (var priority in priorities) {
    if (priority.user.uid == localUser.uid) {
      return priority;
    }
  }
  return null;
}
