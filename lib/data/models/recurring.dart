import 'package:uuid/uuid.dart';

class Recurring {
  final String? uuid;
  String? taskId;
  String? boardId;
  bool? isRecurring;
  int? interval;
  String? period;
  DateTime? startDate;
  DateTime? endDate;
  List<int>? selectedDays;
  String? selectedMonth;
  int? selectedMonthlyDay;

  Recurring(
      {String? uuid,
      this.taskId,
      this.boardId,
      this.isRecurring,
      this.interval,
      this.period,
      this.startDate,
      this.endDate,
      this.selectedDays,
      this.selectedMonth,
      this.selectedMonthlyDay})
      : uuid = uuid ?? Uuid().v4();

  factory Recurring.fromJson(Map<String, dynamic> json) {
    return Recurring(
      uuid: json['uuid'],
      taskId: json['taskId'],
      boardId: json['boardId'],
      isRecurring: json['isRecurring'],
      interval: json['interval'],
      period: json['period'],
      startDate:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      selectedDays: json['selectedDays'] != null
          ? List<int>.from(json['selectedDays'])
          : null,
      selectedMonth: json['selectedMonth'],
      selectedMonthlyDay: json['selectedMonthlyDay'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'taskId': taskId,
      'boardId': boardId,
      'isRecurring': isRecurring,
      'interval': interval,
      'period': period,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'selectedDays': selectedDays,
      'selectedMonth': selectedMonth,
      'selectedMonthlyDay': selectedMonthlyDay,
    };
  }
}
