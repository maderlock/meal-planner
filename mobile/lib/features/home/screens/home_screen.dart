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
import 'package:meal_planner/features/meals/models/meal_model.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealsAsync = ref.watch(mealServiceProvider);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authServiceProvider).signOut();
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
              'Welcome back, ${user?.displayName ?? 'User'}!',
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
            child: mealsAsync.when(
              data: (meals) => _buildWeeklyPlanSummary(context, meals ?? []),
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
        icon: const Icon(Icons.calendar_today),
      ),
    );
  }

  Widget _buildWeeklyPlanSummary(BuildContext context, List<MealModel> meals) {
    final today = DateTime.now();
    final weekDays = List.generate(7, (index) {
      final date = today.add(Duration(days: index));
      return date;
    });

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: weekDays.length,
      itemBuilder: (context, index) {
        final date = weekDays[index];
        final dayName = DateFormat('EEEE').format(date);
        final isToday = date.day == today.day && 
                       date.month == today.month && 
                       date.year == today.year;

        // Get the meals for this day (in a real app, this would come from the weekly plan)
        final dayMeals = meals.take(index + 1).toList();

        return Card(
          elevation: isToday ? 4 : 1,
          margin: const EdgeInsets.only(bottom: 8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isToday ? Theme.of(context).primaryColor : Colors.grey[200],
              child: Text(
                dayName.substring(0, 3),
                style: TextStyle(
                  color: isToday ? Colors.white : Colors.black87,
                ),
              ),
            ),
            title: Text(dayName),
            subtitle: Text(
              dayMeals.isEmpty 
                ? 'No meals planned' 
                : '${dayMeals.length} meal(s) planned',
              style: TextStyle(
                color: dayMeals.isEmpty ? Colors.grey : null,
              ),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(AppRoutes.weeklyPlan),
          ),
        );
      },
    );
  }
}
