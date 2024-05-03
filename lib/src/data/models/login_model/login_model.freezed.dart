// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoginM _$LoginMFromJson(Map<String, dynamic> json) {
  return _LoginM.fromJson(json);
}

/// @nodoc
mixin _$LoginM {
  String? get username => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginMCopyWith<LoginM> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginMCopyWith<$Res> {
  factory $LoginMCopyWith(LoginM value, $Res Function(LoginM) then) =
      _$LoginMCopyWithImpl<$Res, LoginM>;
  @useResult
  $Res call({String? username, String? password});
}

/// @nodoc
class _$LoginMCopyWithImpl<$Res, $Val extends LoginM>
    implements $LoginMCopyWith<$Res> {
  _$LoginMCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? password = freezed,
  }) {
    return _then(_value.copyWith(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginMImplCopyWith<$Res> implements $LoginMCopyWith<$Res> {
  factory _$$LoginMImplCopyWith(
          _$LoginMImpl value, $Res Function(_$LoginMImpl) then) =
      __$$LoginMImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? username, String? password});
}

/// @nodoc
class __$$LoginMImplCopyWithImpl<$Res>
    extends _$LoginMCopyWithImpl<$Res, _$LoginMImpl>
    implements _$$LoginMImplCopyWith<$Res> {
  __$$LoginMImplCopyWithImpl(
      _$LoginMImpl _value, $Res Function(_$LoginMImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? password = freezed,
  }) {
    return _then(_$LoginMImpl(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginMImpl implements _LoginM {
  const _$LoginMImpl({required this.username, required this.password});

  factory _$LoginMImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginMImplFromJson(json);

  @override
  final String? username;
  @override
  final String? password;

  @override
  String toString() {
    return 'LoginM(username: $username, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginMImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, username, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginMImplCopyWith<_$LoginMImpl> get copyWith =>
      __$$LoginMImplCopyWithImpl<_$LoginMImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginMImplToJson(
      this,
    );
  }
}

abstract class _LoginM implements LoginM {
  const factory _LoginM(
      {required final String? username,
      required final String? password}) = _$LoginMImpl;

  factory _LoginM.fromJson(Map<String, dynamic> json) = _$LoginMImpl.fromJson;

  @override
  String? get username;
  @override
  String? get password;
  @override
  @JsonKey(ignore: true)
  _$$LoginMImplCopyWith<_$LoginMImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
