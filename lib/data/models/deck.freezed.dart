// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deck.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Deck _$DeckFromJson(Map<String, dynamic> json) {
  return _Deck.fromJson(json);
}

/// @nodoc
mixin _$Deck {
  int? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get desc => throw _privateConstructorUsedError;

  /// Serializes this Deck to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Deck
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeckCopyWith<Deck> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeckCopyWith<$Res> {
  factory $DeckCopyWith(Deck value, $Res Function(Deck) then) =
      _$DeckCopyWithImpl<$Res, Deck>;
  @useResult
  $Res call({int? id, String title, String desc});
}

/// @nodoc
class _$DeckCopyWithImpl<$Res, $Val extends Deck>
    implements $DeckCopyWith<$Res> {
  _$DeckCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Deck
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? desc = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeckImplCopyWith<$Res> implements $DeckCopyWith<$Res> {
  factory _$$DeckImplCopyWith(
          _$DeckImpl value, $Res Function(_$DeckImpl) then) =
      __$$DeckImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String title, String desc});
}

/// @nodoc
class __$$DeckImplCopyWithImpl<$Res>
    extends _$DeckCopyWithImpl<$Res, _$DeckImpl>
    implements _$$DeckImplCopyWith<$Res> {
  __$$DeckImplCopyWithImpl(_$DeckImpl _value, $Res Function(_$DeckImpl) _then)
      : super(_value, _then);

  /// Create a copy of Deck
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? desc = null,
  }) {
    return _then(_$DeckImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeckImpl implements _Deck {
  _$DeckImpl({this.id, required this.title, required this.desc});

  factory _$DeckImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeckImplFromJson(json);

  @override
  final int? id;
  @override
  final String title;
  @override
  final String desc;

  @override
  String toString() {
    return 'Deck(id: $id, title: $title, desc: $desc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeckImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.desc, desc) || other.desc == desc));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, desc);

  /// Create a copy of Deck
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeckImplCopyWith<_$DeckImpl> get copyWith =>
      __$$DeckImplCopyWithImpl<_$DeckImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeckImplToJson(
      this,
    );
  }
}

abstract class _Deck implements Deck {
  factory _Deck(
      {final int? id,
      required final String title,
      required final String desc}) = _$DeckImpl;

  factory _Deck.fromJson(Map<String, dynamic> json) = _$DeckImpl.fromJson;

  @override
  int? get id;
  @override
  String get title;
  @override
  String get desc;

  /// Create a copy of Deck
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeckImplCopyWith<_$DeckImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
