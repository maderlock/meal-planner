/// Weekly meal planning screen.
/// 
/// Allows users to view and edit their meal plan for the week.
/// Supports navigation back to the home screen via back button and swipe.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meal_model.dart';
import '../models/weekly_plan_model.dart';
import '../services/meal_service.dart';

class WeeklyPlanScreen extends ConsumerStatefulWidget {
  const WeeklyPlanScreen({super.key});

  @override
  ConsumerState<WeeklyPlanScreen> createState() => _WeeklyPlanScreenState();
}

class _WeeklyPlanScreenState extends ConsumerState<WeeklyPlanScreen> {
  WeeklyPlan? _currentPlan;
  List<Meal>? _availableMeals;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final plans = await ref.read(mealServiceProvider).getWeeklyPlans();
      final meals = await ref.read(mealServiceProvider).getMeals();
      
      setState(() {
        _currentPlan = plans.isNotEmpty ? plans.first : null;
        _availableMeals = meals;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading weekly plan: $e')),
        );
      }
    }
  }

  Future<void> _assignMeal(int dayOfWeek, String mealType) async {
    if (_currentPlan == null) return;

    final meal = await showDialog<Meal>(
      context: context,
      builder: (context) => MealSelectionDialog(meals: _availableMeals ?? []),
    );

    if (meal == null) return;

    try {
      await ref.read(mealServiceProvider).assignMeal(
        _currentPlan!.id,
        {
          'mealId': meal.id,
          'dayOfWeek': dayOfWeek,
          'mealType': mealType,
        },
      );
      await _loadData();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error assigning meal: $e')),
        );
      }
    }
  }

  Future<void> _removeMeal(String assignmentId) async {
    if (_currentPlan == null) return;

    try {
      await ref.read(mealServiceProvider).removeAssignment(
        _currentPlan!.id,
        assignmentId,
      );
      await _loadData();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error removing meal: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_currentPlan == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No weekly plan found'),
            ElevatedButton(
              onPressed: () async {
                try {
                  final now = DateTime.now();
                  final startOfWeek = now.subtract(
                    Duration(days: now.weekday - 1),
                  );
                  
                  await ref.read(mealServiceProvider).createWeeklyPlan(
                    CreateWeeklyPlanRequest(
                      userId: 'current-user', // Replace with actual user ID
                      startDate: startOfWeek,
                      endDate: startOfWeek.add(const Duration(days: 6)),
                    ),
                  );
                  await _loadData();
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error creating plan: $e')),
                    );
                  }
                }
              },
              child: const Text('Create Weekly Plan'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Meal Plan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          final dayOfWeek = index + 1;
          final assignments = _currentPlan!.assignments
              .where((a) => a.dayOfWeek == dayOfWeek)
              .toList();

          return Card(
            margin: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    _getDayName(dayOfWeek),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                ...['breakfast', 'lunch', 'dinner'].map((mealType) {
                  final assignment = assignments.firstWhere(
                    (a) => a.mealType == mealType,
                    orElse: () => MealAssignment(
                      id: '',
                      weeklyPlanId: _currentPlan!.id,
                      mealId: '',
                      dayOfWeek: dayOfWeek,
                      mealType: mealType,
                      meal: const Meal(
                        id: '',
                        name: '',
                        description: '',
                        ingredients: [],
                        instructions: [],
                        imageUrl: '',
                        createdAt: null,
                        updatedAt: null,
                      ),
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                  );

                  return ListTile(
                    title: Text(mealType.toUpperCase()),
                    subtitle: Text(assignment.meal.name.isEmpty
                        ? 'No meal assigned'
                        : assignment.meal.name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (assignment.meal.name.isNotEmpty)
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _removeMeal(assignment.id),
                          ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => _assignMeal(dayOfWeek, mealType),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getDayName(int dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }
}

class MealSelectionDialog extends StatelessWidget {
  final List<Meal> meals;

  const MealSelectionDialog({
    super.key,
    required this.meals,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Select a Meal',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return ListTile(
                  title: Text(meal.name),
                  subtitle: Text(meal.description),
                  onTap: () => Navigator.of(context).pop(meal),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
