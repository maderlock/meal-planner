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
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'userId')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'weekStartDate')
  DateTime get weekStartDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'mealPlans')
  List<MealAssignment> get assignments => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updatedAt')
  DateTime get updatedAt => throw _privateConstructorUsedError;

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
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'userId') String userId,
      @JsonKey(name: 'weekStartDate') DateTime weekStartDate,
      @JsonKey(name: 'mealPlans') List<MealAssignment> assignments,
      @JsonKey(name: 'createdAt') DateTime createdAt,
      @JsonKey(name: 'updatedAt') DateTime updatedAt});
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
    Object? assignments = null,
    Object? createdAt = null,
    Object? updatedAt = null,
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
      assignments: null == assignments
          ? _value.assignments
          : assignments // ignore: cast_nullable_to_non_nullable
              as List<MealAssignment>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'userId') String userId,
      @JsonKey(name: 'weekStartDate') DateTime weekStartDate,
      @JsonKey(name: 'mealPlans') List<MealAssignment> assignments,
      @JsonKey(name: 'createdAt') DateTime createdAt,
      @JsonKey(name: 'updatedAt') DateTime updatedAt});
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
    Object? assignments = null,
    Object? createdAt = null,
    Object? updatedAt = null,
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
      assignments: null == assignments
          ? _value._assignments
          : assignments // ignore: cast_nullable_to_non_nullable
              as List<MealAssignment>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeeklyPlanModelImpl implements _WeeklyPlanModel {
  const _$WeeklyPlanModelImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'userId') required this.userId,
      @JsonKey(name: 'weekStartDate') required this.weekStartDate,
      @JsonKey(name: 'mealPlans')
      required final List<MealAssignment> assignments,
      @JsonKey(name: 'createdAt') required this.createdAt,
      @JsonKey(name: 'updatedAt') required this.updatedAt})
      : _assignments = assignments;

  factory _$WeeklyPlanModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeeklyPlanModelImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'userId')
  final String userId;
  @override
  @JsonKey(name: 'weekStartDate')
  final DateTime weekStartDate;
  final List<MealAssignment> _assignments;
  @override
  @JsonKey(name: 'mealPlans')
  List<MealAssignment> get assignments {
    if (_assignments is EqualUnmodifiableListView) return _assignments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assignments);
  }

  @override
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'WeeklyPlanModel(id: $id, userId: $userId, weekStartDate: $weekStartDate, assignments: $assignments, createdAt: $createdAt, updatedAt: $updatedAt)';
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
            const DeepCollectionEquality()
                .equals(other._assignments, _assignments) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, weekStartDate,
      const DeepCollectionEquality().hash(_assignments), createdAt, updatedAt);

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
          {@JsonKey(name: 'id') required final String id,
          @JsonKey(name: 'userId') required final String userId,
          @JsonKey(name: 'weekStartDate') required final DateTime weekStartDate,
          @JsonKey(name: 'mealPlans')
          required final List<MealAssignment> assignments,
          @JsonKey(name: 'createdAt') required final DateTime createdAt,
          @JsonKey(name: 'updatedAt') required final DateTime updatedAt}) =
      _$WeeklyPlanModelImpl;

  factory _WeeklyPlanModel.fromJson(Map<String, dynamic> json) =
      _$WeeklyPlanModelImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'userId')
  String get userId;
  @override
  @JsonKey(name: 'weekStartDate')
  DateTime get weekStartDate;
  @override
  @JsonKey(name: 'mealPlans')
  List<MealAssignment> get assignments;
  @override
  @JsonKey(name: 'createdAt')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updatedAt')
  DateTime get updatedAt;

  /// Create a copy of WeeklyPlanModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeeklyPlanModelImplCopyWith<_$WeeklyPlanModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealAssignment _$MealAssignmentFromJson(Map<String, dynamic> json) {
  return _MealAssignment.fromJson(json);
}

/// @nodoc
mixin _$MealAssignment {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'mealId')
  String get mealId => throw _privateConstructorUsedError;
  @JsonKey(name: 'meal')
  MealModel get meal => throw _privateConstructorUsedError;
  @JsonKey(name: 'day')
  String get day => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  MealType get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'notes')
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updatedAt')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this MealAssignment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealAssignment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealAssignmentCopyWith<MealAssignment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealAssignmentCopyWith<$Res> {
  factory $MealAssignmentCopyWith(
          MealAssignment value, $Res Function(MealAssignment) then) =
      _$MealAssignmentCopyWithImpl<$Res, MealAssignment>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'mealId') String mealId,
      @JsonKey(name: 'meal') MealModel meal,
      @JsonKey(name: 'day') String day,
      @JsonKey(name: 'type') MealType type,
      @JsonKey(name: 'notes') String? notes,
      @JsonKey(name: 'createdAt') DateTime createdAt,
      @JsonKey(name: 'updatedAt') DateTime updatedAt});

  $MealModelCopyWith<$Res> get meal;
}

/// @nodoc
class _$MealAssignmentCopyWithImpl<$Res, $Val extends MealAssignment>
    implements $MealAssignmentCopyWith<$Res> {
  _$MealAssignmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealAssignment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mealId = null,
    Object? meal = null,
    Object? day = null,
    Object? type = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mealId: null == mealId
          ? _value.mealId
          : mealId // ignore: cast_nullable_to_non_nullable
              as String,
      meal: null == meal
          ? _value.meal
          : meal // ignore: cast_nullable_to_non_nullable
              as MealModel,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MealType,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of MealAssignment
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
abstract class _$$MealAssignmentImplCopyWith<$Res>
    implements $MealAssignmentCopyWith<$Res> {
  factory _$$MealAssignmentImplCopyWith(_$MealAssignmentImpl value,
          $Res Function(_$MealAssignmentImpl) then) =
      __$$MealAssignmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'mealId') String mealId,
      @JsonKey(name: 'meal') MealModel meal,
      @JsonKey(name: 'day') String day,
      @JsonKey(name: 'type') MealType type,
      @JsonKey(name: 'notes') String? notes,
      @JsonKey(name: 'createdAt') DateTime createdAt,
      @JsonKey(name: 'updatedAt') DateTime updatedAt});

  @override
  $MealModelCopyWith<$Res> get meal;
}

/// @nodoc
class __$$MealAssignmentImplCopyWithImpl<$Res>
    extends _$MealAssignmentCopyWithImpl<$Res, _$MealAssignmentImpl>
    implements _$$MealAssignmentImplCopyWith<$Res> {
  __$$MealAssignmentImplCopyWithImpl(
      _$MealAssignmentImpl _value, $Res Function(_$MealAssignmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealAssignment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? mealId = null,
    Object? meal = null,
    Object? day = null,
    Object? type = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$MealAssignmentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mealId: null == mealId
          ? _value.mealId
          : mealId // ignore: cast_nullable_to_non_nullable
              as String,
      meal: null == meal
          ? _value.meal
          : meal // ignore: cast_nullable_to_non_nullable
              as MealModel,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MealType,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealAssignmentImpl implements _MealAssignment {
  const _$MealAssignmentImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'mealId') required this.mealId,
      @JsonKey(name: 'meal') required this.meal,
      @JsonKey(name: 'day') required this.day,
      @JsonKey(name: 'type') required this.type,
      @JsonKey(name: 'notes') this.notes,
      @JsonKey(name: 'createdAt') required this.createdAt,
      @JsonKey(name: 'updatedAt') required this.updatedAt});

  factory _$MealAssignmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealAssignmentImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'mealId')
  final String mealId;
  @override
  @JsonKey(name: 'meal')
  final MealModel meal;
  @override
  @JsonKey(name: 'day')
  final String day;
  @override
  @JsonKey(name: 'type')
  final MealType type;
  @override
  @JsonKey(name: 'notes')
  final String? notes;
  @override
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'MealAssignment(id: $id, mealId: $mealId, meal: $meal, day: $day, type: $type, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealAssignmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mealId, mealId) || other.mealId == mealId) &&
            (identical(other.meal, meal) || other.meal == meal) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, mealId, meal, day, type, notes, createdAt, updatedAt);

  /// Create a copy of MealAssignment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealAssignmentImplCopyWith<_$MealAssignmentImpl> get copyWith =>
      __$$MealAssignmentImplCopyWithImpl<_$MealAssignmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealAssignmentImplToJson(
      this,
    );
  }
}

abstract class _MealAssignment implements MealAssignment {
  const factory _MealAssignment(
          {@JsonKey(name: 'id') required final String id,
          @JsonKey(name: 'mealId') required final String mealId,
          @JsonKey(name: 'meal') required final MealModel meal,
          @JsonKey(name: 'day') required final String day,
          @JsonKey(name: 'type') required final MealType type,
          @JsonKey(name: 'notes') final String? notes,
          @JsonKey(name: 'createdAt') required final DateTime createdAt,
          @JsonKey(name: 'updatedAt') required final DateTime updatedAt}) =
      _$MealAssignmentImpl;

  factory _MealAssignment.fromJson(Map<String, dynamic> json) =
      _$MealAssignmentImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'mealId')
  String get mealId;
  @override
  @JsonKey(name: 'meal')
  MealModel get meal;
  @override
  @JsonKey(name: 'day')
  String get day;
  @override
  @JsonKey(name: 'type')
  MealType get type;
  @override
  @JsonKey(name: 'notes')
  String? get notes;
  @override
  @JsonKey(name: 'createdAt')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updatedAt')
  DateTime get updatedAt;

  /// Create a copy of MealAssignment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealAssignmentImplCopyWith<_$MealAssignmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
