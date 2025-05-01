import 'dart:math';

import '../models/priority_model.dart';

double calcPriority(double i, double e, double u) {
  if (i <= 0 || e >= 100 || u <= 0) {
    return 0;
  } else {
    double result = log(i) * log(100 - e) * log(u);
    return (result.isNaN || result < 0) ? 0 : result;
  }
}

Priority backCalculate(
    double target, Priority originalPriority, bool holdUrgency) {
  double impact = originalPriority.impact ?? 0;
  double effort = originalPriority.effort ?? 0;
  double urgency = originalPriority.urgency ?? 0;

  double mu = 0.1; // Learning rate
  double errorThreshold = 0.01; // Threshold for stopping the gradient descent
  int maxIterations = 2000; // Maximum number of iterations
  int iteration = 0;
  double currentPriority = 0;

  //avoid getting stuck at extremes
  if (impact < 10) {
    impact = 10;
  }
  if (effort > 90) {
    effort = 90;
  }
  if (urgency < 10) {
    urgency = 10;
  }

  while (iteration < maxIterations) {
    // Calculate the current priority
    currentPriority = calcPriority(impact, effort, urgency);

    // Calculate the error
    double error = currentPriority - target;

    // Check if the error is below the threshold
    if (error.abs() < errorThreshold) {
      // print('Converged after $iteration iterations');
      break;
    }

    // Calculate the gradients
    double gradientImpact = (1 / impact) * log(100 - effort) * log(urgency);
    double gradientEffort = -log(impact) * (1 / (100 - effort)) * log(urgency);
    double gradientUrgency = log(impact) * log(100 - effort) * (1 / urgency);

    // Update the parameters using gradient descent
    impact -= mu * error * gradientImpact;
    effort -= mu * error * gradientEffort;
    if (!holdUrgency) urgency -= mu * error * gradientUrgency;

    // Ensure the values stay within valid ranges
    impact = impact <= 0 ? 0.1 : impact;
    effort = effort >= 100 ? 99.9 : effort;
    if (!holdUrgency) urgency = urgency <= 0 ? 0.1 : urgency;

    impact = impact.clamp(0, 100);
    effort = effort.clamp(0, 100);
    urgency = urgency.clamp(0, 100);

    iteration++;
  }
  if (iteration == maxIterations) {
    print('Did not converge after $iteration iterations');
  }
  // print('Target priority: $target');
//  print('Final priority: $currentPriority');

  return Priority(
      user: originalPriority.user,
      impact: impact,
      effort: effort,
      urgency: urgency);
}
