import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'recipe_suggestion.freezed.dart';
part 'recipe_suggestion.g.dart';

@freezed
class RecipeSuggestion with _$RecipeSuggestion {
  const factory RecipeSuggestion({
    required String name,
    required String description,
    required List<String> ingredients,
    required List<String> instructions,
    required String cookingTime,
    required String url,
  }) = _RecipeSuggestion;

  factory RecipeSuggestion.fromJson(Map<String, dynamic> json) =>
      _$RecipeSuggestionFromJson(json);
}
