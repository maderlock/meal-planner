import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_planner/features/auth/providers/auth_provider.dart';
import 'package:meal_planner/features/meals/models/meal_model.dart';
import 'package:meal_planner/features/meals/models/weekly_plan_model.dart';
import 'package:meal_planner/features/meals/services/meal_service.dart';

final weeklyPlanProvider = FutureProvider.autoDispose((ref) {
  return ref.watch(mealServiceProvider.notifier).getCurrentWeekPlan();
});

final favoriteMealsProvider = FutureProvider.autoDispose((ref) {
  return ref.watch(mealServiceProvider.notifier).getFavoriteMeals();
});

class WeeklyPlanScreen extends ConsumerWidget {
  const WeeklyPlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyPlanAsync = ref.watch(weeklyPlanProvider);
    final favoriteMealsAsync = ref.watch(favoriteMealsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Meal Plan'),
      ),
      body: weeklyPlanAsync.when(
        data: (weeklyPlan) => favoriteMealsAsync.when(
          data: (favoriteMeals) => _buildPlanList(
            context,
            ref,
            weeklyPlan,
            favoriteMeals,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildPlanList(
    BuildContext context,
    WidgetRef ref,
    WeeklyPlanModel weeklyPlan,
    List<MealModel> favoriteMeals,
  ) {
    final days = [
      {'name': 'Monday', 'dayOfWeek': 1, 'mealType': 'dinner'},
      {'name': 'Tuesday', 'dayOfWeek': 2, 'mealType': 'dinner'},
      {'name': 'Wednesday', 'dayOfWeek': 3, 'mealType': 'dinner'},
      {'name': 'Thursday', 'dayOfWeek': 4, 'mealType': 'dinner'},
      {'name': 'Friday', 'dayOfWeek': 5, 'mealType': 'dinner'},
      {'name': 'Saturday', 'dayOfWeek': 6, 'mealType': 'lunch'},
      {'name': 'Sunday', 'dayOfWeek': 7, 'mealType': 'lunch'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: days.length,
      itemBuilder: (context, index) {
        final day = days[index];
        final dayOfWeek = day['dayOfWeek'] as int;
        final mealType = day['mealType'] as String;
        
        final mealPlan = weeklyPlan.mealPlans.firstWhere(
          (mp) => mp.dayOfWeek == dayOfWeek && mp.mealType == mealType,
          orElse: () => MealPlanItem(
            id: '',
            weeklyPlanId: weeklyPlan.id,
            mealId: '',
            dayOfWeek: dayOfWeek,
            mealType: mealType,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            meal: const MealModel(
              id: '',
              name: '',
              userId: '',
              createdAt: null,
              updatedAt: null,
            ),
          ),
        );

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${day['name']} - ${mealType.toUpperCase()}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: mealPlan.mealId.isEmpty ? null : mealPlan.mealId,
                  decoration: const InputDecoration(
                    hintText: 'Select a meal',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('No meal selected'),
                    ),
                    ...favoriteMeals.map((meal) => DropdownMenuItem(
                          value: meal.id,
                          child: Text(meal.name),
                        )),
                  ],
                  onChanged: (String? mealId) async {
                    if (mealId != null) {
                      await ref.read(mealServiceProvider.notifier).updateMealPlan(
                            weeklyPlanId: weeklyPlan.id,
                            mealId: mealId,
                            dayOfWeek: dayOfWeek,
                            mealType: mealType,
                          );
                    } else {
                      await ref.read(mealServiceProvider.notifier).removeMealPlan(
                            weeklyPlanId: weeklyPlan.id,
                            dayOfWeek: dayOfWeek,
                            mealType: mealType,
                          );
                    }
                    ref.invalidate(weeklyPlanProvider);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
