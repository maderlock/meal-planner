import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/weekly_plan_model.dart';
import '../services/meal_service.dart';

part 'current_week_plan_provider.g.dart';

/// Provider for the current week's plan.
/// Creates a new plan if one doesn't exist.
@riverpod
Future<WeeklyPlanModel> currentWeekPlan(CurrentWeekPlanRef ref) async {
  final now = DateTime.now();
  // Adjust to start of week (Monday)
  final weekStart = now.subtract(Duration(days: now.weekday - 1));
  final adjustedStart = DateTime(weekStart.year, weekStart.month, weekStart.day);
  
  return await ref.read(mealServiceProvider.notifier)
    .getOrCreateWeeklyPlan(adjustedStart);
}
