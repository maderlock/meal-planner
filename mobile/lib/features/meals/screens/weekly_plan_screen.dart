/// Weekly meal planning screen.
///
/// Allows users to view and edit their meal plan for the week.
/// Supports navigation back to the home screen via back button and swipe.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as developer;

import '../../../core/exceptions/api_exception.dart';
import '../../../core/utils/date_utils.dart';
import '../models/meal_model.dart';
import '../models/weekly_plan_model.dart';
import '../providers/meal_provider.dart';
import '../widgets/meal_chooser.dart';
import '../widgets/meal_selection_dialog.dart';

class WeeklyPlanScreen extends ConsumerStatefulWidget {
  const WeeklyPlanScreen({super.key});

  @override
  ConsumerState<WeeklyPlanScreen> createState() => _WeeklyPlanScreenState();
}

class _WeeklyPlanScreenState extends ConsumerState<WeeklyPlanScreen> {
  WeeklyPlanModel? _currentPlan;
  List<MealModel>? _availableMeals;
  bool _isLoading = true;
  DateTime _selectedWeek = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Use the extension method to get start of week
    _selectedWeek = DateTime.now().startOfWeek;
    _loadData();
  }

  Future<void> _loadData() async {
    developer.log('WeeklyPlanScreen: Starting to load data for week ${_selectedWeek.toIso8601String()}', name: 'WeeklyPlanScreen');
    setState(() => _isLoading = true);
    try {
      // Get or create plan for the selected week
      developer.log('WeeklyPlanScreen: Fetching weekly plan', name: 'WeeklyPlanScreen');
      final plan = await ref
          .read(mealServiceProvider)
          .getOrCreateWeeklyPlan(_selectedWeek);
      developer.log('WeeklyPlanScreen: Weekly plan received: ${plan.id}', name: 'WeeklyPlanScreen');
      
      developer.log('WeeklyPlanScreen: Fetching available meals', name: 'WeeklyPlanScreen');
      final meals = await ref.read(mealServiceProvider).getMeals();
      developer.log('WeeklyPlanScreen: ${meals.length} meals received', name: 'WeeklyPlanScreen');

      if (mounted) {
        developer.log('WeeklyPlanScreen: Updating state with plan and meals', name: 'WeeklyPlanScreen');
        setState(() {
          _currentPlan = plan;
          _availableMeals = meals;
          _isLoading = false;
        });
      }
    } on ApiException catch (e) {
      developer.log('WeeklyPlanScreen: Error loading data: $e', name: 'WeeklyPlanScreen', error: e);
      if (mounted) {
        setState(() => _isLoading = false);
        // Only show error message if it's not a 404 (which is handled by creating a new plan)
        if (e.statusCode != 404) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message)),
          );
        }
      }
    } catch (e) {
      developer.log('WeeklyPlanScreen: Error loading data: $e', name: 'WeeklyPlanScreen', error: e);
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An unexpected error occurred. Please try again.'),
          ),
        );
      }
    }
  }

  void _changeWeek(int weekOffset) {
    setState(() {
      _selectedWeek = _selectedWeek.add(Duration(days: weekOffset * 7)).startOfWeek;
      _loadData();
    });
  }

  Future<void> _assignMeal(DateTime date) async {
    if (_currentPlan == null || _availableMeals == null) return;

    final selectedType = await showDialog<MealType>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select Meal Type'),
        children: MealType.values
            .map((type) => SimpleDialogOption(
                  onPressed: () => Navigator.pop(context, type),
                  child: Text(type.name.toUpperCase()),
                ))
            .toList(),
      ),
    );

    if (selectedType == null) return;

    final meals = _availableMeals ?? [];
    final selectedMeal = await showDialog<MealModel>(
      context: context,
      builder: (context) => MealSelectionDialog(meals: meals),
    );

    if (selectedMeal != null && mounted) {
      try {
        await ref.read(mealServiceProvider).assignMeal(
          _currentPlan!.id,
          {
            'mealId': selectedMeal.id,
            'day': _getDayName(date),
            'type': selectedType.name,
          },
        );
        await _loadData(); // Refresh data
      } on ApiException catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message)),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Failed to assign meal. Please try again.',
              ),
            ),
          );
        }
      }
    }
  }

  String _getDayName(DateTime date) {
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    // Adjust for weekday where 1 is Monday (dart uses 1 for Monday already)
    return days[date.weekday - 1];
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
              const Text('Failed to load weekly plan'),
              ElevatedButton(
                onPressed: _loadData,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final startDate = _currentPlan!.weekStartDate;
    final dates = List.generate(
      7,
      (index) => startDate.add(Duration(days: index)),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Week of ${DateFormat('MMMM d').format(startDate)}',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => _changeWeek(-1),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => _changeWeek(1),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          final assignments = _currentPlan!.assignments
              .where((a) => a.day == _getDayName(date))
              .toList()
            ..sort((a, b) => a.type.index.compareTo(b.type.index));

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('EEEE, MMMM d').format(date),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _assignMeal(date),
                      ),
                    ],
                  ),
                ),
                if (assignments.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('No meals assigned'),
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
                              await ref
                                  .read(mealServiceProvider)
                                  .removeAssignment(
                                      _currentPlan!.id, assignment.id);
                              await _loadData();
                            } on ApiException catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.message)),
                                );
                              }
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Failed to remove meal. Please try again.',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: MealChooser(
                onMealAdded: () {
                  // Refresh meals list
                  ref.refresh(mealsProvider);
                  // Close dialog
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
