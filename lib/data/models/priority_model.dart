import 'dart:math';
import 'package:opper_submodule/data/models/user.dart';

class OpperPriority {
  double? impact;
  double? effort;
  double? urgency;
  OpperUser user;

  OpperPriority({
    required this.user,
    this.impact,
    this.effort,
    this.urgency,
  });

  double? get priority => _calcPriority(impact, effort, urgency);

  static double? _calcPriority(double? i, double? e, double? u) {
    if (i == null && e == null && u == null) {
      return null;
    }

    i ??= 50;
    e ??= 50;
    u ??= 50;

    if (i <= 0 || e >= 100 || u <= 0) {
      return 0;
    } else {
      double result = log(i) * log(100 - e) * log(u);
      return (result.isNaN || result < 0) ? 0 : result;
    }
  }

  // Add toJson method
  Map<String, dynamic> toJson() {
    return {
      'impact': impact,
      'effort': effort,
      'urgency': urgency,
      'user': user.toJson(),
    };
  }

  // Add fromJson method
  factory OpperPriority.fromJson(Map<String, dynamic> json) {
    return OpperPriority(
      impact: json['impact'],
      effort: json['effort'],
      urgency: json['urgency'],
      user: OpperUser.fromJson(json['user']),
    );
  }
}
