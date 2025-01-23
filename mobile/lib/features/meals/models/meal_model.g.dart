// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MealImpl _$$MealImplFromJson(Map<String, dynamic> json) => _$MealImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      imageUrl: json['imageUrl'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$MealImplToJson(_$MealImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'ingredients': instance.ingredients,
      'instructions': instance.instructions,
      'imageUrl': instance.imageUrl,
      'isFavorite': instance.isFavorite,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$MealAssignmentImpl _$$MealAssignmentImplFromJson(Map<String, dynamic> json) =>
    _$MealAssignmentImpl(
      id: json['id'] as String,
      weeklyPlanId: json['weeklyPlanId'] as String,
      mealId: json['mealId'] as String,
      dayOfWeek: (json['dayOfWeek'] as num).toInt(),
      mealType: json['mealType'] as String,
      meal: Meal.fromJson(json['meal'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$MealAssignmentImplToJson(
        _$MealAssignmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weeklyPlanId': instance.weeklyPlanId,
      'mealId': instance.mealId,
      'dayOfWeek': instance.dayOfWeek,
      'mealType': instance.mealType,
      'meal': instance.meal,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$FavoriteMealImpl _$$FavoriteMealImplFromJson(Map<String, dynamic> json) =>
    _$FavoriteMealImpl(
      userId: json['userId'] as String,
      mealId: json['mealId'] as String,
      meal: Meal.fromJson(json['meal'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$FavoriteMealImplToJson(_$FavoriteMealImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'mealId': instance.mealId,
      'meal': instance.meal,
      'createdAt': instance.createdAt.toIso8601String(),
    };
