// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_suggestion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeSuggestionImpl _$$RecipeSuggestionImplFromJson(
        Map<String, dynamic> json) =>
    _$RecipeSuggestionImpl(
      name: json['name'] as String,
      description: json['description'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      cookingTime: json['cookingTime'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$RecipeSuggestionImplToJson(
        _$RecipeSuggestionImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'ingredients': instance.ingredients,
      'instructions': instance.instructions,
      'cookingTime': instance.cookingTime,
      'url': instance.url,
    };
