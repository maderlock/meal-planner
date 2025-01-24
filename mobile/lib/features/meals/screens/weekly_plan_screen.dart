/// Weekly meal planning screen.
/// 
/// Allows users to view and edit their meal plan for the week.
/// Supports navigation back to the home screen via back button and swipe.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meal_model.dart';
import '../models/weekly_plan_model.dart';
import '../services/meal_service.dart';
import '../../../core/network/api_client.dart';

class WeeklyPlanScreen extends ConsumerStatefulWidget {
  const WeeklyPlanScreen({super.key});

  @override
  ConsumerState<WeeklyPlanScreen> createState() => _WeeklyPlanScreenState();
}

class _WeeklyPlanScreenState extends ConsumerState<WeeklyPlanScreen> {
  WeeklyPlanModel? _currentPlan;
  List<MealModel>? _availableMeals;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final plans = await ref.read(mealServiceProvider.notifier).getWeeklyPlans();
      final meals = await ref.read(mealServiceProvider.notifier).getMeals();
      
      setState(() {
        _currentPlan = plans.isNotEmpty ? plans.first : null;
        _availableMeals = meals;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e is ApiException 
                ? e.toUserMessage()
                : 'Failed to load weekly plan. Please try again.',
            ),
            action: e is ApiException && e.statusCode == 401 
              ? SnackBarAction(
                  label: 'Login',
                  onPressed: () {
                    // Navigate to login screen
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                )
              : null,
          ),
        );
      }
    }
  }

  Future<void> _assignMeal(DateTime date) async {
    if (_currentPlan == null || _availableMeals == null) return;

    final MealType? selectedType = await showDialog<MealType>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select Meal Type'),
        children: MealType.values.map((type) => SimpleDialogOption(
          onPressed: () => Navigator.pop(context, type),
          child: Text(type.name.toUpperCase()),
        )).toList(),
      ),
    );

    if (selectedType == null) return;

    final MealModel? selectedMeal = await showDialog<MealModel>(
      context: context,
      builder: (context) => MealSelectionDialog(meals: _availableMeals!),
    );

    if (selectedMeal != null && mounted) {
      try {
        await ref.read(mealServiceProvider.notifier).assignMeal(
          _currentPlan!.id,
          {
            'mealId': selectedMeal.id,
            'date': date.toIso8601String(),
            'type': selectedType.name,
          },
        );
        await _loadData(); // Refresh data
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                e is ApiException 
                  ? e.toUserMessage()
                  : 'Failed to assign meal. Please try again.',
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_currentPlan == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Weekly Plan')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('No weekly plan found'),
              ElevatedButton(
                onPressed: _loadData,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final startDate = _currentPlan!.startDate;
    final dates = List.generate(7, (index) => 
      startDate.add(Duration(days: index)),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentPlan!.name ?? 
          'Week of ${startDate.month}/${startDate.day}',
        ),
      ),
      body: ListView.builder(
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          final assignments = _currentPlan!.assignments
            .where((a) => a.date.year == date.year && 
                         a.date.month == date.month && 
                         a.date.day == date.day)
            .toList()
            ..sort((a, b) => a.type.index.compareTo(b.type.index));

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    '${date.month}/${date.day}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => _assignMeal(date),
                  ),
                ),
                if (assignments.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('No meals planned'),
                  )
                else
                  ...assignments.map((assignment) => ListTile(
                    leading: Text(
                      assignment.type.name.toUpperCase(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    title: Text(assignment.meal.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        try {
                          await ref.read(mealServiceProvider.notifier)
                            .removeAssignment(_currentPlan!.id, assignment.id);
                          await _loadData();
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  e is ApiException 
                                    ? e.toUserMessage()
                                    : 'Failed to remove meal. Please try again.',
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  )),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MealSelectionDialog extends StatelessWidget {
  final List<MealModel> meals;

  const MealSelectionDialog({
    super.key,
    required this.meals,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Select a Meal'),
      children: meals.map((meal) => SimpleDialogOption(
        onPressed: () => Navigator.pop(context, meal),
        child: Text(meal.name),
      )).toList(),
    );
  }
}
