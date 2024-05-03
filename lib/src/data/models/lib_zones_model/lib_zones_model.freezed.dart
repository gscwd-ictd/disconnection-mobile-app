// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lib_zones_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LibZones _$LibZonesFromJson(Map<String, dynamic> json) {
  return _LibZones.fromJson(json);
}

/// @nodoc
mixin _$LibZones {
  String? get zone_code => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LibZonesCopyWith<LibZones> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LibZonesCopyWith<$Res> {
  factory $LibZonesCopyWith(LibZones value, $Res Function(LibZones) then) =
      _$LibZonesCopyWithImpl<$Res, LibZones>;
  @useResult
  $Res call({String? zone_code, String? description});
}

/// @nodoc
class _$LibZonesCopyWithImpl<$Res, $Val extends LibZones>
    implements $LibZonesCopyWith<$Res> {
  _$LibZonesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? zone_code = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      zone_code: freezed == zone_code
          ? _value.zone_code
          : zone_code // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LibZonesImplCopyWith<$Res>
    implements $LibZonesCopyWith<$Res> {
  factory _$$LibZonesImplCopyWith(
          _$LibZonesImpl value, $Res Function(_$LibZonesImpl) then) =
      __$$LibZonesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? zone_code, String? description});
}

/// @nodoc
class __$$LibZonesImplCopyWithImpl<$Res>
    extends _$LibZonesCopyWithImpl<$Res, _$LibZonesImpl>
    implements _$$LibZonesImplCopyWith<$Res> {
  __$$LibZonesImplCopyWithImpl(
      _$LibZonesImpl _value, $Res Function(_$LibZonesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? zone_code = freezed,
    Object? description = freezed,
  }) {
    return _then(_$LibZonesImpl(
      zone_code: freezed == zone_code
          ? _value.zone_code
          : zone_code // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LibZonesImpl implements _LibZones {
  const _$LibZonesImpl({required this.zone_code, required this.description});

  factory _$LibZonesImpl.fromJson(Map<String, dynamic> json) =>
      _$$LibZonesImplFromJson(json);

  @override
  final String? zone_code;
  @override
  final String? description;

  @override
  String toString() {
    return 'LibZones(zone_code: $zone_code, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LibZonesImpl &&
            (identical(other.zone_code, zone_code) ||
                other.zone_code == zone_code) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, zone_code, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LibZonesImplCopyWith<_$LibZonesImpl> get copyWith =>
      __$$LibZonesImplCopyWithImpl<_$LibZonesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LibZonesImplToJson(
      this,
    );
  }
}

abstract class _LibZones implements LibZones {
  const factory _LibZones(
      {required final String? zone_code,
      required final String? description}) = _$LibZonesImpl;

  factory _LibZones.fromJson(Map<String, dynamic> json) =
      _$LibZonesImpl.fromJson;

  @override
  String? get zone_code;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$LibZonesImplCopyWith<_$LibZonesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
