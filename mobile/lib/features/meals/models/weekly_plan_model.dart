import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'meal_model.dart';

part 'weekly_plan_model.freezed.dart';
part 'weekly_plan_model.g.dart';

@freezed
class WeeklyPlanModel with _$WeeklyPlanModel {
  const factory WeeklyPlanModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'week_start_date') required DateTime weekStartDate,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'meal_plans') @Default([]) List<MealPlanItem> mealPlans,
  }) = _WeeklyPlanModel;

  factory WeeklyPlanModel.fromJson(Map<String, dynamic> json) =>
      _$WeeklyPlanModelFromJson(json);
}

@freezed
class MealPlanItem with _$MealPlanItem {
  const factory MealPlanItem({
    required String id,
    @JsonKey(name: 'weekly_plan_id') required String weeklyPlanId,
    @JsonKey(name: 'meal_id') required String mealId,
    @JsonKey(name: 'day_of_week') required int dayOfWeek,
    @JsonKey(name: 'meal_type') required String mealType,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    required MealModel meal,
  }) = _MealPlanItem;

  factory MealPlanItem.fromJson(Map<String, dynamic> json) =>
      _$MealPlanItemFromJson(json);
}
