/// Model class representing a meal in the application.
/// 
/// This file is responsible for:
/// - Defining the meal data structure
/// - Handling JSON serialization/deserialization
/// - Providing immutable meal objects
/// - Supporting copy operations for state updates
/// 
/// Referenced by:
/// - Used by MealService for data operations
/// - Used by meal-related screens for display
/// - Used in weekly meal plans
/// 
/// Dependencies:
/// - No external package dependencies
/// - Part of the meals feature module

/// Represents a meal with its properties.
class MealModel {
  /// Unique identifier for the meal.
  final String id;

  /// Name of the meal.
  final String name;

  /// Brief description of the meal.
  final String description;

  /// List of ingredients required for the meal.
  final List<String> ingredients;

  /// Step-by-step instructions for preparing the meal.
  final List<String> instructions;

  /// URL of the meal's image.
  final String imageUrl;

  /// Timestamp when the meal was created.
  final DateTime createdAt;

  /// Timestamp when the meal was last updated.
  final DateTime updatedAt;

  /// Constructs a new [MealModel] instance.
  MealModel({
    required this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Creates a new [MealModel] instance from a JSON object.
  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      ingredients: List<String>.from(json['ingredients'] as List),
      instructions: List<String>.from(json['instructions'] as List),
      imageUrl: json['imageUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the [MealModel] instance to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'ingredients': ingredients,
      'instructions': instructions,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Creates a copy of the [MealModel] instance with optional updates.
  MealModel copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? ingredients,
    List<String>? instructions,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MealModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  /// Checks if the [MealModel] instance is equal to another object.
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          ingredients == other.ingredients &&
          instructions == other.instructions &&
          imageUrl == other.imageUrl &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  /// Returns the hash code for the [MealModel] instance.
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      ingredients.hashCode ^
      instructions.hashCode ^
      imageUrl.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
