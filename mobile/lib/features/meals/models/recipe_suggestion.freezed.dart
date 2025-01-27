// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_suggestion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecipeSuggestion _$RecipeSuggestionFromJson(Map<String, dynamic> json) {
  return _RecipeSuggestion.fromJson(json);
}

/// @nodoc
mixin _$RecipeSuggestion {
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String> get ingredients => throw _privateConstructorUsedError;
  List<String> get instructions => throw _privateConstructorUsedError;
  int? get cookingTime => throw _privateConstructorUsedError;
  String? get sourceUrl => throw _privateConstructorUsedError;

  /// Serializes this RecipeSuggestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecipeSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipeSuggestionCopyWith<RecipeSuggestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeSuggestionCopyWith<$Res> {
  factory $RecipeSuggestionCopyWith(
          RecipeSuggestion value, $Res Function(RecipeSuggestion) then) =
      _$RecipeSuggestionCopyWithImpl<$Res, RecipeSuggestion>;
  @useResult
  $Res call(
      {String name,
      String? description,
      List<String> ingredients,
      List<String> instructions,
      int? cookingTime,
      String? sourceUrl});
}

/// @nodoc
class _$RecipeSuggestionCopyWithImpl<$Res, $Val extends RecipeSuggestion>
    implements $RecipeSuggestionCopyWith<$Res> {
  _$RecipeSuggestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecipeSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? ingredients = null,
    Object? instructions = null,
    Object? cookingTime = freezed,
    Object? sourceUrl = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      ingredients: null == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      instructions: null == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      cookingTime: freezed == cookingTime
          ? _value.cookingTime
          : cookingTime // ignore: cast_nullable_to_non_nullable
              as int?,
      sourceUrl: freezed == sourceUrl
          ? _value.sourceUrl
          : sourceUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipeSuggestionImplCopyWith<$Res>
    implements $RecipeSuggestionCopyWith<$Res> {
  factory _$$RecipeSuggestionImplCopyWith(_$RecipeSuggestionImpl value,
          $Res Function(_$RecipeSuggestionImpl) then) =
      __$$RecipeSuggestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String? description,
      List<String> ingredients,
      List<String> instructions,
      int? cookingTime,
      String? sourceUrl});
}

/// @nodoc
class __$$RecipeSuggestionImplCopyWithImpl<$Res>
    extends _$RecipeSuggestionCopyWithImpl<$Res, _$RecipeSuggestionImpl>
    implements _$$RecipeSuggestionImplCopyWith<$Res> {
  __$$RecipeSuggestionImplCopyWithImpl(_$RecipeSuggestionImpl _value,
      $Res Function(_$RecipeSuggestionImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecipeSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? ingredients = null,
    Object? instructions = null,
    Object? cookingTime = freezed,
    Object? sourceUrl = freezed,
  }) {
    return _then(_$RecipeSuggestionImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      ingredients: null == ingredients
          ? _value._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      instructions: null == instructions
          ? _value._instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      cookingTime: freezed == cookingTime
          ? _value.cookingTime
          : cookingTime // ignore: cast_nullable_to_non_nullable
              as int?,
      sourceUrl: freezed == sourceUrl
          ? _value.sourceUrl
          : sourceUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeSuggestionImpl
    with DiagnosticableTreeMixin
    implements _RecipeSuggestion {
  const _$RecipeSuggestionImpl(
      {required this.name,
      this.description,
      required final List<String> ingredients,
      required final List<String> instructions,
      this.cookingTime,
      this.sourceUrl})
      : _ingredients = ingredients,
        _instructions = instructions;

  factory _$RecipeSuggestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeSuggestionImplFromJson(json);

  @override
  final String name;
  @override
  final String? description;
  final List<String> _ingredients;
  @override
  List<String> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  final List<String> _instructions;
  @override
  List<String> get instructions {
    if (_instructions is EqualUnmodifiableListView) return _instructions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_instructions);
  }

  @override
  final int? cookingTime;
  @override
  final String? sourceUrl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RecipeSuggestion(name: $name, description: $description, ingredients: $ingredients, instructions: $instructions, cookingTime: $cookingTime, sourceUrl: $sourceUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RecipeSuggestion'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('ingredients', ingredients))
      ..add(DiagnosticsProperty('instructions', instructions))
      ..add(DiagnosticsProperty('cookingTime', cookingTime))
      ..add(DiagnosticsProperty('sourceUrl', sourceUrl));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeSuggestionImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients) &&
            const DeepCollectionEquality()
                .equals(other._instructions, _instructions) &&
            (identical(other.cookingTime, cookingTime) ||
                other.cookingTime == cookingTime) &&
            (identical(other.sourceUrl, sourceUrl) ||
                other.sourceUrl == sourceUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      description,
      const DeepCollectionEquality().hash(_ingredients),
      const DeepCollectionEquality().hash(_instructions),
      cookingTime,
      sourceUrl);

  /// Create a copy of RecipeSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeSuggestionImplCopyWith<_$RecipeSuggestionImpl> get copyWith =>
      __$$RecipeSuggestionImplCopyWithImpl<_$RecipeSuggestionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeSuggestionImplToJson(
      this,
    );
  }
}

abstract class _RecipeSuggestion implements RecipeSuggestion {
  const factory _RecipeSuggestion(
      {required final String name,
      final String? description,
      required final List<String> ingredients,
      required final List<String> instructions,
      final int? cookingTime,
      final String? sourceUrl}) = _$RecipeSuggestionImpl;

  factory _RecipeSuggestion.fromJson(Map<String, dynamic> json) =
      _$RecipeSuggestionImpl.fromJson;

  @override
  String get name;
  @override
  String? get description;
  @override
  List<String> get ingredients;
  @override
  List<String> get instructions;
  @override
  int? get cookingTime;
  @override
  String? get sourceUrl;

  /// Create a copy of RecipeSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipeSuggestionImplCopyWith<_$RecipeSuggestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
