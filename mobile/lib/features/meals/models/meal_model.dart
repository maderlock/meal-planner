/// Model classes representing meals and their assignments in the application.
/// 
/// These represent global meals that can be assigned to weekly plans.
/// The meal contains core information like name, description, and instructions,
/// but these details are loaded on demand to optimize data transfer.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_model.freezed.dart';
part 'meal_model.g.dart';

@freezed
class MealModel with _$MealModel {
  const factory MealModel({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'instructions') List<String>? instructions,
    @JsonKey(name: 'ingredients') required List<String> ingredients,
    @JsonKey(name: 'createdAt') required DateTime createdAt,
    @JsonKey(name: 'updatedAt') required DateTime updatedAt,
    @JsonKey(name: 'isFavorite') @Default(false) bool isFavorite,
  }) = _MealModel;

  factory MealModel.fromJson(Map<String, dynamic> json) =>
      _$MealModelFromJson(json);
}

/// Represents a meal that has been marked as a favorite by a user.
/// Only stores the relationship between user and meal, the full meal
/// data is loaded separately when needed.
@freezed
class FavoriteMeal with _$FavoriteMeal {
  const factory FavoriteMeal({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'userId') required String userId,
    @JsonKey(name: 'mealId') required String mealId,
    @JsonKey(name: 'createdAt') required DateTime createdAt,
    @JsonKey(name: 'updatedAt') required DateTime updatedAt,
  }) = _FavoriteMeal;

  factory FavoriteMeal.fromJson(Map<String, dynamic> json) =>
      _$FavoriteMealFromJson(json);
}
