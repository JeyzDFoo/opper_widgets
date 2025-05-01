import 'package:opper_submodule/data/models/priority_model.dart';
import 'package:opper_submodule/data/models/user.dart';

updatePriorities(List<Priority>? priorities, Priority? priority) {
  if (priorities == null) {
    priorities = [];
  }
  if (priority != null) {
    priorities.add(priority);
  }
  return priorities;
}

Priority? getLocalPriority(List<Priority> priorities, OpperUser localUser) {
  for (var priority in priorities) {
    if (priority.user.uid == localUser.uid) {
      return priority;
    }
  }
  return null;
}
