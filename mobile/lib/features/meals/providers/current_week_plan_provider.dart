import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:developer' as developer;

import '../../../core/utils/date_utils.dart';
import '../models/weekly_plan_model.dart';
import 'meal_provider.dart';

part 'current_week_plan_provider.g.dart';

/// Provider that manages the current week's meal plan
@riverpod
class CurrentWeekPlan extends AutoDisposeAsyncNotifier<WeeklyPlanModel> {
  @override
  Future<WeeklyPlanModel> build() async {
    final now = DateTime.now();
    final startOfWeek = now.startOfWeek;
    developer.log('Fetching plan for week starting ${startOfWeek.toIso8601String()}',
        name: 'CurrentWeekPlan');

    try {
      final mealService = ref.watch(mealServiceProvider);
      developer.log('Calling getOrCreateWeeklyPlan', name: 'CurrentWeekPlan');
      final plan = await mealService.getOrCreateWeeklyPlan(startOfWeek);
      developer.log('Successfully received plan: ${plan.id}', name: 'CurrentWeekPlan');
      return plan;
    } catch (e) {
      developer.log('Error fetching plan: $e', name: 'CurrentWeekPlan', error: e);
      rethrow;
    }
  }

  Future<void> refresh() async {
    developer.log('Refreshing weekly plan', name: 'CurrentWeekPlan');
    state = const AsyncLoading();
    state = await AsyncValue.guard(build);
    developer.log('Refresh complete, state: ${state.value?.id ?? "error"}',
        name: 'CurrentWeekPlan');
  }
}
