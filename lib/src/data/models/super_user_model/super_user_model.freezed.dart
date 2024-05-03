// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'super_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SuperUser _$SuperUserFromJson(Map<String, dynamic> json) {
  return _SuperUser.fromJson(json);
}

/// @nodoc
mixin _$SuperUser {
  String? get userId => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  Team? get team => throw _privateConstructorUsedError;
  String? get accessToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SuperUserCopyWith<SuperUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SuperUserCopyWith<$Res> {
  factory $SuperUserCopyWith(SuperUser value, $Res Function(SuperUser) then) =
      _$SuperUserCopyWithImpl<$Res, SuperUser>;
  @useResult
  $Res call(
      {String? userId, String? username, Team? team, String? accessToken});

  $TeamCopyWith<$Res>? get team;
}

/// @nodoc
class _$SuperUserCopyWithImpl<$Res, $Val extends SuperUser>
    implements $SuperUserCopyWith<$Res> {
  _$SuperUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? username = freezed,
    Object? team = freezed,
    Object? accessToken = freezed,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as Team?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TeamCopyWith<$Res>? get team {
    if (_value.team == null) {
      return null;
    }

    return $TeamCopyWith<$Res>(_value.team!, (value) {
      return _then(_value.copyWith(team: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SuperUserImplCopyWith<$Res>
    implements $SuperUserCopyWith<$Res> {
  factory _$$SuperUserImplCopyWith(
          _$SuperUserImpl value, $Res Function(_$SuperUserImpl) then) =
      __$$SuperUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? userId, String? username, Team? team, String? accessToken});

  @override
  $TeamCopyWith<$Res>? get team;
}

/// @nodoc
class __$$SuperUserImplCopyWithImpl<$Res>
    extends _$SuperUserCopyWithImpl<$Res, _$SuperUserImpl>
    implements _$$SuperUserImplCopyWith<$Res> {
  __$$SuperUserImplCopyWithImpl(
      _$SuperUserImpl _value, $Res Function(_$SuperUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? username = freezed,
    Object? team = freezed,
    Object? accessToken = freezed,
  }) {
    return _then(_$SuperUserImpl(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as Team?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SuperUserImpl implements _SuperUser {
  const _$SuperUserImpl(
      {required this.userId,
      required this.username,
      required this.team,
      required this.accessToken});

  factory _$SuperUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$SuperUserImplFromJson(json);

  @override
  final String? userId;
  @override
  final String? username;
  @override
  final Team? team;
  @override
  final String? accessToken;

  @override
  String toString() {
    return 'SuperUser(userId: $userId, username: $username, team: $team, accessToken: $accessToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuperUserImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, username, team, accessToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuperUserImplCopyWith<_$SuperUserImpl> get copyWith =>
      __$$SuperUserImplCopyWithImpl<_$SuperUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SuperUserImplToJson(
      this,
    );
  }
}

abstract class _SuperUser implements SuperUser {
  const factory _SuperUser(
      {required final String? userId,
      required final String? username,
      required final Team? team,
      required final String? accessToken}) = _$SuperUserImpl;

  factory _SuperUser.fromJson(Map<String, dynamic> json) =
      _$SuperUserImpl.fromJson;

  @override
  String? get userId;
  @override
  String? get username;
  @override
  Team? get team;
  @override
  String? get accessToken;
  @override
  @JsonKey(ignore: true)
  _$$SuperUserImplCopyWith<_$SuperUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
