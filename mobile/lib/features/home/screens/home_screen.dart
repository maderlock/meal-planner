/// Home screen of the application.
/// 
/// Displays a summary of the user's meal plan for the week and
/// provides navigation to the detailed meal planning screen.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planner/core/router/app_router.dart';
import 'package:meal_planner/features/meals/services/meal_service.dart';
import 'package:meal_planner/features/auth/providers/auth_provider.dart';
import 'package:meal_planner/features/meals/models/weekly_plan_model.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyPlanAsync = ref.watch(mealServiceProvider);
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
            child: weeklyPlanAsync.when(
              data: (weeklyPlans) => _buildWeeklyPlanSummary(context, weeklyPlans),
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

  Widget _buildWeeklyPlanSummary(BuildContext context, List<WeeklyPlanModel> plans) {
    if (plans.isEmpty) {
      return const Center(
        child: Text('No meal plans yet. Create one!'),
      );
    }

    // Find the current week's plan
    final now = DateTime.now();
    final currentPlan = plans.firstWhere(
      (plan) => plan.startDate.isBefore(now) && plan.endDate.isAfter(now),
      orElse: () => plans.first,
    );

    // Group assignments by date
    final assignmentsByDate = <DateTime, List<MealAssignment>>{};
    for (final assignment in currentPlan.assignments) {
      final date = DateTime(
        assignment.date.year,
        assignment.date.month,
        assignment.date.day,
      );
      assignmentsByDate.putIfAbsent(date, () => []).add(assignment);
    }

    // Sort dates
    final dates = assignmentsByDate.keys.toList()
      ..sort((a, b) => a.compareTo(b));

    if (dates.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No meals planned for ${DateFormat('MMMM d').format(currentPlan.startDate)} - ${DateFormat('MMMM d').format(currentPlan.endDate)}',
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
      itemCount: dates.length,
      itemBuilder: (context, index) {
        final date = dates[index];
        final assignments = assignmentsByDate[date]!;
        assignments.sort((a, b) => a.type.index.compareTo(b.type.index));

        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('EEEE, MMMM d').format(date),
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
}
