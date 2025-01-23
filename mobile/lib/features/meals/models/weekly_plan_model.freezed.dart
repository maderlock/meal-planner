// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_plan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeeklyPlanModel _$WeeklyPlanModelFromJson(Map<String, dynamic> json) {
  return _WeeklyPlanModel.fromJson(json);
}

/// @nodoc
mixin _$WeeklyPlanModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'week_start_date')
  DateTime get weekStartDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'meal_plans')
  List<MealPlanItem> get mealPlans => throw _privateConstructorUsedError;

  /// Serializes this WeeklyPlanModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WeeklyPlanModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeeklyPlanModelCopyWith<WeeklyPlanModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklyPlanModelCopyWith<$Res> {
  factory $WeeklyPlanModelCopyWith(
          WeeklyPlanModel value, $Res Function(WeeklyPlanModel) then) =
      _$WeeklyPlanModelCopyWithImpl<$Res, WeeklyPlanModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'week_start_date') DateTime weekStartDate,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'meal_plans') List<MealPlanItem> mealPlans});
}

/// @nodoc
class _$WeeklyPlanModelCopyWithImpl<$Res, $Val extends WeeklyPlanModel>
    implements $WeeklyPlanModelCopyWith<$Res> {
  _$WeeklyPlanModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeeklyPlanModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? weekStartDate = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? mealPlans = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      weekStartDate: null == weekStartDate
          ? _value.weekStartDate
          : weekStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mealPlans: null == mealPlans
          ? _value.mealPlans
          : mealPlans // ignore: cast_nullable_to_non_nullable
              as List<MealPlanItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeeklyPlanModelImplCopyWith<$Res>
    implements $WeeklyPlanModelCopyWith<$Res> {
  factory _$$WeeklyPlanModelImplCopyWith(_$WeeklyPlanModelImpl value,
          $Res Function(_$WeeklyPlanModelImpl) then) =
      __$$WeeklyPlanModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'week_start_date') DateTime weekStartDate,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'meal_plans') List<MealPlanItem> mealPlans});
}

/// @nodoc
class __$$WeeklyPlanModelImplCopyWithImpl<$Res>
    extends _$WeeklyPlanModelCopyWithImpl<$Res, _$WeeklyPlanModelImpl>
    implements _$$WeeklyPlanModelImplCopyWith<$Res> {
  __$$WeeklyPlanModelImplCopyWithImpl(
      _$WeeklyPlanModelImpl _value, $Res Function(_$WeeklyPlanModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of WeeklyPlanModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? weekStartDate = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? mealPlans = null,
  }) {
    return _then(_$WeeklyPlanModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      weekStartDate: null == weekStartDate
          ? _value.weekStartDate
          : weekStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mealPlans: null == mealPlans
          ? _value._mealPlans
          : mealPlans // ignore: cast_nullable_to_non_nullable
              as List<MealPlanItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeeklyPlanModelImpl implements _WeeklyPlanModel {
  const _$WeeklyPlanModelImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'week_start_date') required this.weekStartDate,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt,
      @JsonKey(name: 'meal_plans')
      final List<MealPlanItem> mealPlans = const []})
      : _mealPlans = mealPlans;

  factory _$WeeklyPlanModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeeklyPlanModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'week_start_date')
  final DateTime weekStartDate;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  final List<MealPlanItem> _mealPlans;
  @override
  @JsonKey(name: 'meal_plans')
  List<MealPlanItem> get mealPlans {
    if (_mealPlans is EqualUnmodifiableListView) return _mealPlans;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mealPlans);
  }

  @override
  String toString() {
    return 'WeeklyPlanModel(id: $id, userId: $userId, weekStartDate: $weekStartDate, createdAt: $createdAt, updatedAt: $updatedAt, mealPlans: $mealPlans)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklyPlanModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.weekStartDate, weekStartDate) ||
                other.weekStartDate == weekStartDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality()
                .equals(other._mealPlans, _mealPlans));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, weekStartDate,
      createdAt, updatedAt, const DeepCollectionEquality().hash(_mealPlans));

  /// Create a copy of WeeklyPlanModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklyPlanModelImplCopyWith<_$WeeklyPlanModelImpl> get copyWith =>
      __$$WeeklyPlanModelImplCopyWithImpl<_$WeeklyPlanModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeeklyPlanModelImplToJson(
      this,
    );
  }
}

abstract class _WeeklyPlanModel implements WeeklyPlanModel {
  const factory _WeeklyPlanModel(
      {required final String id,
      @JsonKey(name: 'user_id') required final String userId,
      @JsonKey(name: 'week_start_date') required final DateTime weekStartDate,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'updated_at') required final DateTime updatedAt,
      @JsonKey(name: 'meal_plans')
      final List<MealPlanItem> mealPlans}) = _$WeeklyPlanModelImpl;

  factory _WeeklyPlanModel.fromJson(Map<String, dynamic> json) =
      _$WeeklyPlanModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'week_start_date')
  DateTime get weekStartDate;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override
  @JsonKey(name: 'meal_plans')
  List<MealPlanItem> get mealPlans;

  /// Create a copy of WeeklyPlanModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeeklyPlanModelImplCopyWith<_$WeeklyPlanModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealPlanItem _$MealPlanItemFromJson(Map<String, dynamic> json) {
  return _MealPlanItem.fromJson(json);
}

/// @nodoc
mixin _$MealPlanItem {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'weekly_plan_id')
  String get weeklyPlanId => throw _privateConstructorUsedError;
  @JsonKey(name: 'meal_id')
  String get mealId => throw _privateConstructorUsedError;
  @JsonKey(name: 'day_of_week')
  int get dayOfWeek => throw _privateConstructorUsedError;
  @JsonKey(name: 'meal_type')
  String get mealType => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;
  MealModel get meal => throw _privateConstructorUsedError;

  /// Serializes this MealPlanItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealPlanItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealPlanItemCopyWith<MealPlanItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealPlanItemCopyWith<$Res> {
  factory $MealPlanItemCopyWith(
          MealPlanItem value, $Res Function(MealPlanItem) then) =
      _$MealPlanItemCopyWithImpl<$Res, MealPlanItem>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'weekly_plan_id') String weeklyPlanId,
      @JsonKey(name: 'meal_id') String mealId,
      @JsonKey(name: 'day_of_week') int dayOfWeek,
      @JsonKey(name: 'meal_type') String mealType,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      MealModel meal});

  $MealModelCopyWith<$Res> get meal;
}

/// @nodoc
class _$MealPlanItemCopyWithImpl<$Res, $Val extends MealPlanItem>
    implements $MealPlanItemCopyWith<$Res> {
  _$MealPlanItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealPlanItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weeklyPlanId = null,
    Object? mealId = null,
    Object? dayOfWeek = null,
    Object? mealType = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? meal = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      weeklyPlanId: null == weeklyPlanId
          ? _value.weeklyPlanId
          : weeklyPlanId // ignore: cast_nullable_to_non_nullable
              as String,
      mealId: null == mealId
          ? _value.mealId
          : mealId // ignore: cast_nullable_to_non_nullable
              as String,
      dayOfWeek: null == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as int,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      meal: null == meal
          ? _value.meal
          : meal // ignore: cast_nullable_to_non_nullable
              as MealModel,
    ) as $Val);
  }

  /// Create a copy of MealPlanItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MealModelCopyWith<$Res> get meal {
    return $MealModelCopyWith<$Res>(_value.meal, (value) {
      return _then(_value.copyWith(meal: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MealPlanItemImplCopyWith<$Res>
    implements $MealPlanItemCopyWith<$Res> {
  factory _$$MealPlanItemImplCopyWith(
          _$MealPlanItemImpl value, $Res Function(_$MealPlanItemImpl) then) =
      __$$MealPlanItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'weekly_plan_id') String weeklyPlanId,
      @JsonKey(name: 'meal_id') String mealId,
      @JsonKey(name: 'day_of_week') int dayOfWeek,
      @JsonKey(name: 'meal_type') String mealType,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      MealModel meal});

  @override
  $MealModelCopyWith<$Res> get meal;
}

/// @nodoc
class __$$MealPlanItemImplCopyWithImpl<$Res>
    extends _$MealPlanItemCopyWithImpl<$Res, _$MealPlanItemImpl>
    implements _$$MealPlanItemImplCopyWith<$Res> {
  __$$MealPlanItemImplCopyWithImpl(
      _$MealPlanItemImpl _value, $Res Function(_$MealPlanItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealPlanItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weeklyPlanId = null,
    Object? mealId = null,
    Object? dayOfWeek = null,
    Object? mealType = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? meal = null,
  }) {
    return _then(_$MealPlanItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      weeklyPlanId: null == weeklyPlanId
          ? _value.weeklyPlanId
          : weeklyPlanId // ignore: cast_nullable_to_non_nullable
              as String,
      mealId: null == mealId
          ? _value.mealId
          : mealId // ignore: cast_nullable_to_non_nullable
              as String,
      dayOfWeek: null == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as int,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      meal: null == meal
          ? _value.meal
          : meal // ignore: cast_nullable_to_non_nullable
              as MealModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealPlanItemImpl implements _MealPlanItem {
  const _$MealPlanItemImpl(
      {required this.id,
      @JsonKey(name: 'weekly_plan_id') required this.weeklyPlanId,
      @JsonKey(name: 'meal_id') required this.mealId,
      @JsonKey(name: 'day_of_week') required this.dayOfWeek,
      @JsonKey(name: 'meal_type') required this.mealType,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt,
      required this.meal});

  factory _$MealPlanItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealPlanItemImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'weekly_plan_id')
  final String weeklyPlanId;
  @override
  @JsonKey(name: 'meal_id')
  final String mealId;
  @override
  @JsonKey(name: 'day_of_week')
  final int dayOfWeek;
  @override
  @JsonKey(name: 'meal_type')
  final String mealType;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  final MealModel meal;

  @override
  String toString() {
    return 'MealPlanItem(id: $id, weeklyPlanId: $weeklyPlanId, mealId: $mealId, dayOfWeek: $dayOfWeek, mealType: $mealType, createdAt: $createdAt, updatedAt: $updatedAt, meal: $meal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealPlanItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.weeklyPlanId, weeklyPlanId) ||
                other.weeklyPlanId == weeklyPlanId) &&
            (identical(other.mealId, mealId) || other.mealId == mealId) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.mealType, mealType) ||
                other.mealType == mealType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.meal, meal) || other.meal == meal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, weeklyPlanId, mealId,
      dayOfWeek, mealType, createdAt, updatedAt, meal);

  /// Create a copy of MealPlanItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealPlanItemImplCopyWith<_$MealPlanItemImpl> get copyWith =>
      __$$MealPlanItemImplCopyWithImpl<_$MealPlanItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealPlanItemImplToJson(
      this,
    );
  }
}

abstract class _MealPlanItem implements MealPlanItem {
  const factory _MealPlanItem(
      {required final String id,
      @JsonKey(name: 'weekly_plan_id') required final String weeklyPlanId,
      @JsonKey(name: 'meal_id') required final String mealId,
      @JsonKey(name: 'day_of_week') required final int dayOfWeek,
      @JsonKey(name: 'meal_type') required final String mealType,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'updated_at') required final DateTime updatedAt,
      required final MealModel meal}) = _$MealPlanItemImpl;

  factory _MealPlanItem.fromJson(Map<String, dynamic> json) =
      _$MealPlanItemImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'weekly_plan_id')
  String get weeklyPlanId;
  @override
  @JsonKey(name: 'meal_id')
  String get mealId;
  @override
  @JsonKey(name: 'day_of_week')
  int get dayOfWeek;
  @override
  @JsonKey(name: 'meal_type')
  String get mealType;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override
  MealModel get meal;

  /// Create a copy of MealPlanItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealPlanItemImplCopyWith<_$MealPlanItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
