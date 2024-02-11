// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'proof_of_disconnection_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProofOfDisconnection _$ProofOfDisconnectionFromJson(Map<String, dynamic> json) {
  return _ProofOfDisconnection.fromJson(json);
}

/// @nodoc
mixin _$ProofOfDisconnection {
  String? get id => throw _privateConstructorUsedError;
  String? get fileName => throw _privateConstructorUsedError;
  String? get timestamptz => throw _privateConstructorUsedError;
  String? get disconnectionId => throw _privateConstructorUsedError;
  String? get teamId => throw _privateConstructorUsedError;
  String? get longitude => throw _privateConstructorUsedError;
  String? get latitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProofOfDisconnectionCopyWith<ProofOfDisconnection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProofOfDisconnectionCopyWith<$Res> {
  factory $ProofOfDisconnectionCopyWith(ProofOfDisconnection value,
          $Res Function(ProofOfDisconnection) then) =
      _$ProofOfDisconnectionCopyWithImpl<$Res, ProofOfDisconnection>;
  @useResult
  $Res call(
      {String? id,
      String? fileName,
      String? timestamptz,
      String? disconnectionId,
      String? teamId,
      String? longitude,
      String? latitude});
}

/// @nodoc
class _$ProofOfDisconnectionCopyWithImpl<$Res,
        $Val extends ProofOfDisconnection>
    implements $ProofOfDisconnectionCopyWith<$Res> {
  _$ProofOfDisconnectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fileName = freezed,
    Object? timestamptz = freezed,
    Object? disconnectionId = freezed,
    Object? teamId = freezed,
    Object? longitude = freezed,
    Object? latitude = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamptz: freezed == timestamptz
          ? _value.timestamptz
          : timestamptz // ignore: cast_nullable_to_non_nullable
              as String?,
      disconnectionId: freezed == disconnectionId
          ? _value.disconnectionId
          : disconnectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProofOfDisconnectionImplCopyWith<$Res>
    implements $ProofOfDisconnectionCopyWith<$Res> {
  factory _$$ProofOfDisconnectionImplCopyWith(_$ProofOfDisconnectionImpl value,
          $Res Function(_$ProofOfDisconnectionImpl) then) =
      __$$ProofOfDisconnectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? fileName,
      String? timestamptz,
      String? disconnectionId,
      String? teamId,
      String? longitude,
      String? latitude});
}

/// @nodoc
class __$$ProofOfDisconnectionImplCopyWithImpl<$Res>
    extends _$ProofOfDisconnectionCopyWithImpl<$Res, _$ProofOfDisconnectionImpl>
    implements _$$ProofOfDisconnectionImplCopyWith<$Res> {
  __$$ProofOfDisconnectionImplCopyWithImpl(_$ProofOfDisconnectionImpl _value,
      $Res Function(_$ProofOfDisconnectionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fileName = freezed,
    Object? timestamptz = freezed,
    Object? disconnectionId = freezed,
    Object? teamId = freezed,
    Object? longitude = freezed,
    Object? latitude = freezed,
  }) {
    return _then(_$ProofOfDisconnectionImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamptz: freezed == timestamptz
          ? _value.timestamptz
          : timestamptz // ignore: cast_nullable_to_non_nullable
              as String?,
      disconnectionId: freezed == disconnectionId
          ? _value.disconnectionId
          : disconnectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      teamId: freezed == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProofOfDisconnectionImpl implements _ProofOfDisconnection {
  const _$ProofOfDisconnectionImpl(
      {required this.id,
      required this.fileName,
      required this.timestamptz,
      required this.disconnectionId,
      required this.teamId,
      required this.longitude,
      required this.latitude});

  factory _$ProofOfDisconnectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProofOfDisconnectionImplFromJson(json);

  @override
  final String? id;
  @override
  final String? fileName;
  @override
  final String? timestamptz;
  @override
  final String? disconnectionId;
  @override
  final String? teamId;
  @override
  final String? longitude;
  @override
  final String? latitude;

  @override
  String toString() {
    return 'ProofOfDisconnection(id: $id, fileName: $fileName, timestamptz: $timestamptz, disconnectionId: $disconnectionId, teamId: $teamId, longitude: $longitude, latitude: $latitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProofOfDisconnectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.timestamptz, timestamptz) ||
                other.timestamptz == timestamptz) &&
            (identical(other.disconnectionId, disconnectionId) ||
                other.disconnectionId == disconnectionId) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, fileName, timestamptz,
      disconnectionId, teamId, longitude, latitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProofOfDisconnectionImplCopyWith<_$ProofOfDisconnectionImpl>
      get copyWith =>
          __$$ProofOfDisconnectionImplCopyWithImpl<_$ProofOfDisconnectionImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProofOfDisconnectionImplToJson(
      this,
    );
  }
}

abstract class _ProofOfDisconnection implements ProofOfDisconnection {
  const factory _ProofOfDisconnection(
      {required final String? id,
      required final String? fileName,
      required final String? timestamptz,
      required final String? disconnectionId,
      required final String? teamId,
      required final String? longitude,
      required final String? latitude}) = _$ProofOfDisconnectionImpl;

  factory _ProofOfDisconnection.fromJson(Map<String, dynamic> json) =
      _$ProofOfDisconnectionImpl.fromJson;

  @override
  String? get id;
  @override
  String? get fileName;
  @override
  String? get timestamptz;
  @override
  String? get disconnectionId;
  @override
  String? get teamId;
  @override
  String? get longitude;
  @override
  String? get latitude;
  @override
  @JsonKey(ignore: true)
  _$$ProofOfDisconnectionImplCopyWith<_$ProofOfDisconnectionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
