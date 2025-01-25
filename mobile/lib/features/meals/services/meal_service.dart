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

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:meal_planner/features/meals/models/meal_model.dart';
import 'package:meal_planner/features/meals/models/weekly_plan_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../core/network/api_client.dart';
import '../../../core/config/app_config.dart';

part 'meal_service.g.dart';

@riverpod
class MealService extends _$MealService {
  late final MealServiceApi _api;

  @override
  FutureOr<List<WeeklyPlanModel>> build() async {
    final dio = ref.watch(dioProvider);
    _api = MealServiceApi(dio, baseUrl: AppConfig.instance.baseUrl);
    return getWeeklyPlans();
  }

  Future<List<WeeklyPlanModel>> getWeeklyPlans() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _api.getWeeklyPlans());
    return state.value ?? [];
  }

  /// Gets or creates a weekly plan for the specified week.
  /// If a plan doesn't exist, it will be created automatically.
  Future<WeeklyPlanModel> getOrCreateWeeklyPlan(DateTime weekStartDate) async {
    try {
      // First try to get the existing plan
      final response = await _api.getWeeklyPlanByDate(weekStartDate.toIso8601String());
      return response;
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 404) {
        // Plan doesn't exist, create a new one
        final endDate = weekStartDate.add(const Duration(days: 6));
        final request = CreateWeeklyPlanRequest.fromDate(weekStartDate);
        return await _api.createWeeklyPlan(request);
      }
      rethrow;
    }
  }

  Future<WeeklyPlanModel> getWeeklyPlan(String id) async {
    final response = await _api.getWeeklyPlan(id);
    return response;
  }

  Future<List<MealModel>> getMeals() async {
    final response = await _api.getMeals();
    return response;
  }

  Future<MealModel> getMeal(String id) async {
    final response = await _api.getMeal(id);
    return response;
  }

  Future<WeeklyPlanModel> createWeeklyPlan(CreateWeeklyPlanRequest request) async {
    final response = await _api.createWeeklyPlan(request);
    await getWeeklyPlans(); // Refresh state
    return response;
  }

  Future<WeeklyPlanModel> updateWeeklyPlan(
    String id,
    UpdateWeeklyPlanRequest request,
  ) async {
    final response = await _api.updateWeeklyPlan(id, request);
    await getWeeklyPlans(); // Refresh state
    return response;
  }

  Future<void> assignMeal(String weeklyPlanId, Map<String, dynamic> assignment) async {
    await _api.assignMeal(weeklyPlanId, assignment);
    await getWeeklyPlans(); // Refresh state
  }

  Future<void> removeAssignment(String weeklyPlanId, String assignmentId) async {
    await _api.removeAssignment(weeklyPlanId, assignmentId);
    await getWeeklyPlans(); // Refresh state
  }

  Future<List<MealModel>> getFavorites() async {
    final response = await _api.getFavorites();
    return response;
  }

  Future<void> addFavorite(String mealId) async {
    await _api.addFavorite({'mealId': mealId});
  }

  Future<void> removeFavorite(String id) async {
    await _api.removeFavorite(id);
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

  @GET('/weekly-plans')
  Future<WeeklyPlanModel> getWeeklyPlanByDate(
    @Query('weekStartDate') String weekStartDate,
  );

  @POST('/weekly-plans')
  Future<WeeklyPlanModel> createWeeklyPlan(@Body() CreateWeeklyPlanRequest request);

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
}

/// Request model for creating a new weekly plan.
@JsonSerializable()
class CreateWeeklyPlanRequest {
  @JsonKey(name: 'weekStartDate')
  final String weekStartDate;

  CreateWeeklyPlanRequest(this.weekStartDate);

  CreateWeeklyPlanRequest.fromDate(DateTime startDate)
      : weekStartDate = startDate.toIso8601String();

  factory CreateWeeklyPlanRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateWeeklyPlanRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateWeeklyPlanRequestToJson(this);
}

/// Request model for updating an existing weekly plan.
