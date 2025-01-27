import 'package:json_annotation/json_annotation.dart';

part 'recipe_suggestion.g.dart';

@JsonSerializable()
class RecipeSuggestion {
  const RecipeSuggestion({
    required this.name,
    this.description,
    required this.ingredients,
    required this.instructions,
    this.cookingTime,
    this.sourceUrl,
  });

  factory RecipeSuggestion.fromJson(Map<String, dynamic> json) =>
      _$RecipeSuggestionFromJson(json);

  /// The name of the recipe
  @JsonKey(name: 'name')
  final String name;

  /// Optional description of the recipe
  @JsonKey(name: 'description')
  final String? description;

  /// List of ingredients needed for the recipe
  @JsonKey(name: 'ingredients')
  final List<String> ingredients;

  /// Step by step cooking instructions
  @JsonKey(name: 'instructions')
  final List<String> instructions;

  /// Optional cooking time in minutes
  @JsonKey(name: 'cookingTime')
  final int? cookingTime;

  /// Optional URL to the recipe source
  @JsonKey(name: 'sourceUrl')
  final String? sourceUrl;

  /// Converts the recipe suggestion to a JSON map
  Map<String, dynamic> toJson() => _$RecipeSuggestionToJson(this);

  /// Creates a copy of this RecipeSuggestion with the given fields replaced with new values
  RecipeSuggestion copyWith({
    String? name,
    String? description,
    List<String>? ingredients,
    List<String>? instructions,
    int? cookingTime,
    String? sourceUrl,
  }) =>
      RecipeSuggestion(
        name: name ?? this.name,
        description: description ?? this.description,
        ingredients: ingredients ?? this.ingredients,
        instructions: instructions ?? this.instructions,
        cookingTime: cookingTime ?? this.cookingTime,
        sourceUrl: sourceUrl ?? this.sourceUrl,
      );
}
