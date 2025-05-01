import 'dart:math';

import 'package:intl/intl.dart';

// Define bounds for days remaining
const int minDays = 1; // Minimum days remaining
const int maxDays = 1825; // Maximum days remaining (5 years)

// Example days_remaining values
List<int> daysRemaining = [365, 100, 50, 14, 7, 1]; // Test values

// Backcalculate linear_scalar
List<double> linearScalar = daysRemaining.map((days) {
  return (log(days) - log(minDays)) / (log(maxDays) - log(minDays));
}).toList();

int calcRemainingDays(double scalar) {
  // Ensure scalar is within valid range
  if (scalar <= 0) scalar = 0;
  if (scalar >= 100) scalar = 100;

  // Rescale scalar to 0-1
  scalar = scalar / 100;

  // Handle edge cases where scalar is exactly 0 or 1
  if (scalar == 0) return minDays;
  if (scalar == 100) return maxDays;

  // Calculate days remaining from the scalar
  return (pow(maxDays, scalar) * pow(minDays, 1 - scalar)).toInt();
}

int calcRemainingMinutes(double scalar) {
  // Ensure scalar is within valid range
  if (scalar < 0) scalar = 0;
  if (scalar > 100) scalar = 100;

  // Rescale scalar to 0-1
  scalar = scalar / 100;

  // Handle edge cases where scalar is exactly 0 or 1
  if (scalar == 0) return minDays * 24 * 60 - 1440;
  if (scalar == 100) return maxDays * 24 * 60 - 1440;

  // Calculate days remaining from the scalar
  return (pow(maxDays * 24 * 60, scalar) * pow(minDays * 24 * 60, 1 - scalar))
          .round() -
      1440; //subtract 24 hours to be at the end of the day.
}

String calcTimeOutFromUrgency(double urgency) {
  int remainingMinutes = calcRemainingMinutes(100 - urgency);
  if (remainingMinutes < (24 * 60)) {
    DateTime targetTime =
        DateTime.now().add(Duration(minutes: remainingMinutes));

    // Round to the next largest 15 minutes
    int minute = targetTime.minute;
    int roundedMinute = ((minute + 14) ~/ 15) * 15;
    if (roundedMinute == 60) {
      targetTime = DateTime(targetTime.year, targetTime.month, targetTime.day,
          targetTime.hour + 1, 0);
    } else {
      targetTime = DateTime(targetTime.year, targetTime.month, targetTime.day,
          targetTime.hour, roundedMinute);
    }

    String formattedTime = DateFormat('h:mm a').format(targetTime);
    return "$formattedTime";
  }
  // Calculate days remaining from the scalar
  int daysRemaining = calcRemainingDays(100 - urgency);

  // Calculate weeks and months
  int weeksRemaining = daysRemaining ~/ 7;
  int monthsRemaining = daysRemaining ~/ 30;
  int yearsRemaining = daysRemaining ~/ 365;

  if (daysRemaining == 0) {
    return 'Now';
  }

  if (daysRemaining == 1) {
    return 'Today';
  } else if (daysRemaining == 2) {
    return 'Tomorrow';
  } else if (yearsRemaining > 1) {
    return '$yearsRemaining year${yearsRemaining > 1 ? 's' : ''}';
  } else if (monthsRemaining > 0) {
    return '$monthsRemaining month${monthsRemaining > 1 ? 's' : ''}';
  } else if (weeksRemaining > 1) {
    return '$weeksRemaining week${weeksRemaining > 1 ? 's' : ''}';
  } else {
    return '$daysRemaining day${daysRemaining > 1 ? 's' : ''}';
  }
}

String calcRemainingFromDate(DateTime startDate) {
  // Calculate days remaining from the scalar
  int daysRemaining = startDate.difference(DateTime.now()).inDays;

  // Check if daysRemaining is negative and return overdue message if true
  if (daysRemaining < 0) {
    return 'Overdue by ${-daysRemaining} days';
  }

  if (daysRemaining == 0) {
    return 'Due today';
  }

  if (daysRemaining == 1) {
    return 'Due tomorrow';
  }

  // Check if daysRemaining is greater than 5 weeks (35 days) and return in months if true
  if (daysRemaining > 35) {
    int monthsRemaining = (daysRemaining / 30).round();
    return 'Due in $monthsRemaining months';
  }

  // Check if daysRemaining is greater than 14 and return in weeks if true
  if (daysRemaining > 14) {
    int weeksRemaining = (daysRemaining / 7).round();
    return 'Due in $weeksRemaining weeks';
  }

  // Return the days remaining as a string
  return 'Due in $daysRemaining days';
}

DateTime calcEndDate(double scalar) {
  // Calculate days remaining from the scalar
  int daysRemaining = calcRemainingDays(100 - scalar) - 1;
  // Calculate the end date
  return DateTime.now().add(Duration(days: daysRemaining));
}

double calcUrgencyFromEndDate(DateTime endDate) {
  int hoursRemaining = endDate.difference(DateTime.now()).inHours +
      24; //add 24 to be at the end of the end date.
  double daysRemaining = hoursRemaining / 24;

  if (daysRemaining <= 0) {
    return 100;
  }

  double urgency =
      1 - (log(daysRemaining) - log(minDays)) / (log(maxDays) - log(minDays));
  urgency = urgency * 100;
  // Calculate the scalar from the days remaining
  if (urgency <= 0) {
    return 0;
  }

  if (urgency >= 100) {
    return 100;
  }

  return urgency;
}

// Print results
void main() {
  DateTime endDate = DateTime.now().add(const Duration(days: 364));
  double urgency = calcUrgencyFromEndDate(endDate);
  print('End Date: $endDate, Urgency: ${urgency.toString()}');
}
