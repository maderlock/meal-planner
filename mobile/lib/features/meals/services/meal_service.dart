/// Service for managing meal-related operations.
///
/// This service is responsible for:
/// - Managing meal data in local state
/// - Handling meal-related operations
/// - Providing meal data to the UI
///
/// Dependencies:
/// - Uses Riverpod for state management
/// - Uses Dio and Retrofit for API calls

import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/app_config.dart';
import '../../../core/network/api_client.dart';
import '../../../core/utils/date_utils.dart';
import '../models/meal_model.dart';
import '../models/recipe_suggestion.dart';
import '../models/weekly_plan_model.dart';

part 'meal_service.g.dart';

class MealService {
  MealService(this._api);
  final MealServiceApi _api;

  Future<List<WeeklyPlanModel>> getWeeklyPlans() async => _api.getWeeklyPlans();

  Future<WeeklyPlanModel> getWeeklyPlan(String id) async =>
      _api.getWeeklyPlan(id);

  /// Gets or creates a weekly plan for the specified week.
  /// If a plan doesn't exist, it will be created automatically.
  Future<WeeklyPlanModel> getOrCreateWeeklyPlan(DateTime weekStartDate) async {
    try {
      // First try to get the existing plan
      developer.log(
          'MealService: Attempting to get plan for ${weekStartDate.toIso8601String()}',
          name: 'MealService');
      final response =
          await _api.getWeeklyPlanByDate(weekStartDate.toIso8601String());
      developer.log('MealService: Successfully retrieved plan: ${response.id}',
          name: 'MealService');
      return response;
    } catch (e) {
      developer.log('MealService: Error getting plan: $e',
          name: 'MealService', error: e);
      if (e is DioException && e.response?.statusCode == 404) {
        // Plan doesn't exist, create a new one
        developer.log('MealService: Plan not found, creating new plan',
            name: 'MealService');
        final request = CreateWeeklyPlanRequest.fromDate(weekStartDate);
        final newPlan = await _api.createWeeklyPlan(request);
        developer.log(
            'MealService: Successfully created new plan: ${newPlan.id}',
            name: 'MealService');
        return newPlan;
      }
      rethrow;
    }
  }

  Future<List<MealModel>> getMeals() async => _api.getMeals();

  Future<MealModel> getMeal(String id) async => _api.getMeal(id);

  Future<WeeklyPlanModel> createWeeklyPlan(
          CreateWeeklyPlanRequest request) async =>
      _api.createWeeklyPlan(request);

  Future<WeeklyPlanModel> updateWeeklyPlan(
    String id,
    UpdateWeeklyPlanRequest request,
  ) async =>
      _api.updateWeeklyPlan(id, request);

  Future<void> assignMeal(
    String weeklyPlanId,
    Map<String, dynamic> assignment,
  ) async =>
      _api.assignMeal(weeklyPlanId, assignment);

  Future<void> removeAssignment(
    String weeklyPlanId,
    String assignmentId,
  ) async {
    await _api.removeAssignment(weeklyPlanId, assignmentId);
  }

  Future<List<MealModel>> getFavorites() async => _api.getFavorites();

  Future<void> addFavorite(String mealId) async {
    await _api.addFavorite({'mealId': mealId});
  }

  Future<void> removeFavorite(String id) async {
    await _api.removeFavorite(id);
  }

  Future<List<RecipeSuggestion>> suggestRecipes(String description) async {
    try {
      developer.log('Requesting recipe suggestions for: $description',
          name: 'MealService');
      final response = await _api.suggestRecipes({'description': description});
      developer.log('Got recipe suggestions response: $response',
          name: 'MealService');
      return response;
    } catch (e, stackTrace) {
      developer.log(
        'Error getting recipe suggestions',
        name: 'MealService',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<void> saveSuggestedRecipe(RecipeSuggestion suggestion) async {
    await _api.saveSuggestedRecipe(suggestion);
  }
}

@riverpod
class WeeklyPlans extends AutoDisposeAsyncNotifier<List<WeeklyPlanModel>> {
  late MealService _mealService;

  @override
  FutureOr<List<WeeklyPlanModel>> build() async {
    final dio = ref.watch(dioProvider);
    final api = MealServiceApi(dio, baseUrl: AppConfig.instance.baseUrl);
    _mealService = MealService(api);
    return _mealService.getWeeklyPlans();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _mealService.getWeeklyPlans());
  }
}

@RestApi()
abstract class MealServiceApi {
  factory MealServiceApi(Dio dio, {String? baseUrl}) = _MealServiceApi;

  @GET('/meals')
  Future<List<MealModel>> getMeals();

  @GET('/meals/{id}')
  Future<MealModel> getMeal(@Path('id') String id);

  @GET('/weekly-plans')
  Future<List<WeeklyPlanModel>> getWeeklyPlans();

  @GET('/weekly-plans/{id}')
  Future<WeeklyPlanModel> getWeeklyPlan(@Path('id') String id);

  @GET('/weekly-plans/by-date')
  Future<WeeklyPlanModel> getWeeklyPlanByDate(
    @Query('weekStartDate') String weekStartDate,
  );

  @POST('/weekly-plans')
  Future<WeeklyPlanModel> createWeeklyPlan(
      @Body() CreateWeeklyPlanRequest request);

  @PUT('/weekly-plans/{id}')
  Future<WeeklyPlanModel> updateWeeklyPlan(
    @Path('id') String id,
    @Body() UpdateWeeklyPlanRequest request,
  );

  @POST('/weekly-plans/{id}/assignments')
  Future<void> assignMeal(
    @Path('id') String id,
    @Body() Map<String, dynamic> assignment,
  );

  @DELETE('/weekly-plans/{id}/assignments/{assignmentId}')
  Future<void> removeAssignment(
    @Path('id') String id,
    @Path('assignmentId') String assignmentId,
  );

  @GET('/meals/favorites')
  Future<List<MealModel>> getFavorites();

  @POST('/meals/favorites')
  Future<void> addFavorite(@Body() Map<String, String> request);

  @DELETE('/meals/favorites/{id}')
  Future<void> removeFavorite(@Path('id') String id);

  @POST('/meals/suggest')
  Future<List<RecipeSuggestion>> suggestRecipes(
      @Body() Map<String, String> request);

  @POST('/meals/save-suggestion')
  Future<void> saveSuggestedRecipe(@Body() RecipeSuggestion suggestion);
}

/// Request model for creating a new weekly plan.
@JsonSerializable()
class CreateWeeklyPlanRequest {
  CreateWeeklyPlanRequest({required this.weekStartDate});

  CreateWeeklyPlanRequest.fromDate(DateTime startDate)
      : weekStartDate = startDate.startOfWeek.toIso8601String();

  factory CreateWeeklyPlanRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateWeeklyPlanRequestFromJson(json);
  @JsonKey(name: 'weekStartDate')
  final String weekStartDate;

  Map<String, dynamic> toJson() => _$CreateWeeklyPlanRequestToJson(this);
}
