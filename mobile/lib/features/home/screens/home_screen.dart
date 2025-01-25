/// Home screen of the application.
/// 
/// Displays a summary of the user's meal plan for the week and
/// provides navigation to the detailed meal planning screen.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planner/core/router/app_router.dart';
import 'package:meal_planner/features/meals/providers/current_week_plan_provider.dart';
import 'package:meal_planner/features/auth/providers/auth_provider.dart';
import 'package:meal_planner/features/meals/models/weekly_plan_model.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPlanAsync = ref.watch(currentWeekPlanProvider);
    final userName = ref.watch(userDisplayNameProvider) ?? 'User';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authStateProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Welcome back, $userName!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Your meal plan for this week:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: currentPlanAsync.when(
              data: (plan) => _buildWeeklyPlanSummary(context, plan),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.weeklyPlan),
        label: const Text('Plan Meals'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildWeeklyPlanSummary(BuildContext context, WeeklyPlanModel plan) {
    // Group assignments by day
    final assignmentsByDay = <String, List<MealAssignment>>{};
    for (final assignment in plan.assignments) {
      assignmentsByDay.putIfAbsent(assignment.day, () => []).add(assignment);
    }

    // Sort days
    final days = assignmentsByDay.keys.toList()
      ..sort((a, b) => _dayToNumber(a).compareTo(_dayToNumber(b)));

    if (days.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No meals planned for week of ${DateFormat('MMMM d').format(plan.weekStartDate)}',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => context.push(AppRoutes.weeklyPlan),
              child: const Text('Add Meals'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: days.length,
      itemBuilder: (context, index) {
        final day = days[index];
        final assignments = assignmentsByDay[day]!;
        assignments.sort((a, b) => a.type.index.compareTo(b.type.index));

        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ...assignments.map((assignment) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          assignment.type.name.toUpperCase(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          assignment.meal.name,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        );
      },
    );
  }

  int _dayToNumber(String day) {
    const days = {
      'Monday': 1,
      'Tuesday': 2,
      'Wednesday': 3,
      'Thursday': 4,
      'Friday': 5,
      'Saturday': 6,
      'Sunday': 7,
    };
    return days[day] ?? 0;
  }
}
