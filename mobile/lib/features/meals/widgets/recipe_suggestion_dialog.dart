import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_planner/features/meals/models/recipe_suggestion.dart';
import 'package:meal_planner/features/meals/providers/meal_provider.dart';
import 'package:meal_planner/core/widgets/loading_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeSuggestionDialog extends ConsumerStatefulWidget {
  const RecipeSuggestionDialog({super.key});

  @override
  ConsumerState<RecipeSuggestionDialog> createState() => _RecipeSuggestionDialogState();
}

class _RecipeSuggestionDialogState extends ConsumerState<RecipeSuggestionDialog> {
  final _descriptionController = TextEditingController();
  List<RecipeSuggestion>? _suggestions;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _getSuggestions() async {
    if (_descriptionController.text.isEmpty) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final suggestions = await ref.read(mealServiceProvider)
          .suggestRecipes(_descriptionController.text);
      setState(() {
        _suggestions = suggestions;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to get suggestions. Please try again.';
        _loading = false;
      });
    }
  }

  Future<void> _saveSuggestion(RecipeSuggestion suggestion) async {
    setState(() => _loading = true);

    try {
      await ref.read(mealServiceProvider).saveSuggestedRecipe(suggestion);
      // Refresh meals list
      ref.refresh(mealsProvider);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Added ${suggestion.name} to your meals')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add meal')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _openRecipeUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Get Recipe Suggestions',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Describe the type of meal you want...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loading ? null : _getSuggestions,
                  child: const Text('Get Suggestions'),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _error!,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ],
                if (_suggestions != null) ...[
                  const SizedBox(height: 16),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _suggestions!.length,
                      itemBuilder: (context, index) {
                        final suggestion = _suggestions![index];
                        return Card(
                          child: ExpansionTile(
                            title: Text(suggestion.name),
                            subtitle: Text(
                              suggestion.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Cooking Time: ${suggestion.cookingTime}'),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Ingredients:',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    ...suggestion.ingredients.map((i) => Text('• $i')),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Instructions:',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    ...suggestion.instructions
                                        .asMap()
                                        .entries
                                        .map((e) => Text('${e.key + 1}. ${e.value}')),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () => _openRecipeUrl(suggestion.url),
                                          child: const Text('View Original Recipe'),
                                        ),
                                        ElevatedButton(
                                          onPressed: _loading
                                              ? null
                                              : () => _saveSuggestion(suggestion),
                                          child: const Text('Add to My Meals'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        if (_loading) const LoadingOverlay(),
      ],
    );
  }
}
