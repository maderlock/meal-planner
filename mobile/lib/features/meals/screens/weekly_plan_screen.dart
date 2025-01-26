/// Weekly meal planning screen.
/// 
/// Allows users to view and edit their meal plan for the week.
/// Supports navigation back to the home screen via back button and swipe.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_planner/core/exceptions/api_exception.dart';
import 'package:meal_planner/features/meals/models/meal_model.dart';
import 'package:meal_planner/features/meals/models/weekly_plan_model.dart';
import 'package:meal_planner/features/meals/providers/meal_provider.dart';
import 'package:meal_planner/features/meals/widgets/meal_chooser.dart';
import 'package:meal_planner/features/meals/widgets/meal_selection_dialog.dart';
import 'package:intl/intl.dart';

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
    // Adjust to start of week (Monday)
    _selectedWeek = _selectedWeek.subtract(
      Duration(days: _selectedWeek.weekday - 1)
    );
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      // Get or create plan for the selected week
      final plan = await ref.read(mealServiceProvider).getOrCreateWeeklyPlan(_selectedWeek);
      final meals = await ref.read(mealServiceProvider).getMeals();
      
      setState(() {
        _currentPlan = plan;
        _availableMeals = meals;
        _isLoading = false;
      });
    } on ApiException catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to load weekly plan. Please try again.',
            ),
          ),
        );
      }
    }
  }

  void _changeWeek(int weekOffset) {
    setState(() {
      _selectedWeek = _selectedWeek.add(Duration(days: weekOffset * 7));
    });
    _loadData();
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

    final meals = _availableMeals ?? [];
    final MealModel? selectedMeal = await showDialog<MealModel>(
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
            SnackBar(
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
    final dates = List.generate(7, (index) => 
      startDate.add(Duration(days: index)),
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
                          await ref.read(mealServiceProvider).removeAssignment(_currentPlan!.id, assignment.id);
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
                              SnackBar(
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
