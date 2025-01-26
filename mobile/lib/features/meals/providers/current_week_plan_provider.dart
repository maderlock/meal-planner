import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:meal_planner/features/meals/models/weekly_plan_model.dart';
import 'package:meal_planner/features/meals/providers/meal_provider.dart';

part 'current_week_plan_provider.g.dart';

/// Provider that manages the current week's meal plan
@riverpod
class CurrentWeekPlan extends AutoDisposeAsyncNotifier<WeeklyPlanModel> {
  @override
  Future<WeeklyPlanModel> build() async {
    final DateTime now = DateTime.now();
    final DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    try {
      final mealService = ref.watch(mealServiceProvider);
      final plan = await mealService.getOrCreateWeeklyPlan(startOfWeek);
      return plan;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build());
  }
}
