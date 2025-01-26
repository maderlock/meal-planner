import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meal_model.dart';
import '../services/meal_service.dart' as service;
import '../providers/meal_provider.dart';

/// A reusable dialog for selecting meals from a list.
/// Shows favorites first with a star icon, and includes a button to add new meals.
class MealSelectionDialog extends ConsumerStatefulWidget {
  /// Optional list of pre-loaded meals. If provided, the dialog won't load meals from the API.
  final List<MealModel>? meals;

  const MealSelectionDialog({
    super.key,
    this.meals,
  });

  @override
  ConsumerState<MealSelectionDialog> createState() =>
      _MealSelectionDialogState();
}

class _MealSelectionDialogState extends ConsumerState<MealSelectionDialog> {
  bool _isLoading = true;
  List<MealModel> _meals = [];
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    if (widget.meals != null) {
      setState(() {
        _meals = widget.meals!;
        _isLoading = false;
      });
    } else {
      _loadMeals();
    }
  }

  Future<void> _loadMeals() async {
    try {
      setState(() => _isLoading = true);
      final meals = await ref.read(mealServiceProvider).getMeals();
      setState(() {
        _meals = meals;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load meals')),
        );
      }
    }
  }

  Future<void> _showNewMealDialog() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Create New Meal'),
        content: const Text('AI-powered meal creation coming soon!'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select a Meal',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_errorMessage != null)
              Center(
                child: Column(
                  children: [
                    Text(_errorMessage!),
                    TextButton(
                      onPressed: _loadMeals,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              )
            else
              Flexible(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.5,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _meals.length,
                    itemBuilder: (context, index) {
                      final meal = _meals[index];
                      return ListTile(
                        leading: meal.isFavorite
                            ? const Icon(Icons.star, color: Colors.amber)
                            : const SizedBox(width: 24),
                        title: Text(meal.name),
                        subtitle: Text(
                          meal.description ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () => Navigator.of(context).pop(meal),
                      );
                    },
                  ),
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _showNewMealDialog,
              icon: const Icon(Icons.add),
              label: const Text('Create New Meal'),
            ),
          ],
        ),
      ),
    );
  }
}
