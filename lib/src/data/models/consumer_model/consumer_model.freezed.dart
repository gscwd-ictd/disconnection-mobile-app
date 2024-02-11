// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consumer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConsumerModel _$ConsumerModelFromJson(Map<String, dynamic> json) {
  return _ConsumerModel.fromJson(json);
}

/// @nodoc
mixin _$ConsumerModel {
  String? get disconnectionId => throw _privateConstructorUsedError;
  String? get accountNo => throw _privateConstructorUsedError;
  String? get prevAccountNo => throw _privateConstructorUsedError;
  String? get consumerName => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get meterNo => throw _privateConstructorUsedError;
  String? get billAmount => throw _privateConstructorUsedError;
  int? get noOfMonths => throw _privateConstructorUsedError;
  int? get lastReading => throw _privateConstructorUsedError;
  int? get currentReading => throw _privateConstructorUsedError;
  String? get remarks => throw _privateConstructorUsedError;
  DateTime? get disconnectionDate => throw _privateConstructorUsedError;
  DateTime? get disconnectedDate => throw _privateConstructorUsedError;
  int? get zoneNo => throw _privateConstructorUsedError;
  int? get bookNo => throw _privateConstructorUsedError;
  bool? get isConnected => throw _privateConstructorUsedError;
  bool? get isPayed => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;
  Team? get disconnectionTeam => throw _privateConstructorUsedError;
  List<ProofOfDisconnection>? get proofOfDisconnection =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConsumerModelCopyWith<ConsumerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsumerModelCopyWith<$Res> {
  factory $ConsumerModelCopyWith(
          ConsumerModel value, $Res Function(ConsumerModel) then) =
      _$ConsumerModelCopyWithImpl<$Res, ConsumerModel>;
  @useResult
  $Res call(
      {String? disconnectionId,
      String? accountNo,
      String? prevAccountNo,
      String? consumerName,
      String? address,
      String? meterNo,
      String? billAmount,
      int? noOfMonths,
      int? lastReading,
      int? currentReading,
      String? remarks,
      DateTime? disconnectionDate,
      DateTime? disconnectedDate,
      int? zoneNo,
      int? bookNo,
      bool? isConnected,
      bool? isPayed,
      int? status,
      Team? disconnectionTeam,
      List<ProofOfDisconnection>? proofOfDisconnection});

  $TeamCopyWith<$Res>? get disconnectionTeam;
}

/// @nodoc
class _$ConsumerModelCopyWithImpl<$Res, $Val extends ConsumerModel>
    implements $ConsumerModelCopyWith<$Res> {
  _$ConsumerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? disconnectionId = freezed,
    Object? accountNo = freezed,
    Object? prevAccountNo = freezed,
    Object? consumerName = freezed,
    Object? address = freezed,
    Object? meterNo = freezed,
    Object? billAmount = freezed,
    Object? noOfMonths = freezed,
    Object? lastReading = freezed,
    Object? currentReading = freezed,
    Object? remarks = freezed,
    Object? disconnectionDate = freezed,
    Object? disconnectedDate = freezed,
    Object? zoneNo = freezed,
    Object? bookNo = freezed,
    Object? isConnected = freezed,
    Object? isPayed = freezed,
    Object? status = freezed,
    Object? disconnectionTeam = freezed,
    Object? proofOfDisconnection = freezed,
  }) {
    return _then(_value.copyWith(
      disconnectionId: freezed == disconnectionId
          ? _value.disconnectionId
          : disconnectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      accountNo: freezed == accountNo
          ? _value.accountNo
          : accountNo // ignore: cast_nullable_to_non_nullable
              as String?,
      prevAccountNo: freezed == prevAccountNo
          ? _value.prevAccountNo
          : prevAccountNo // ignore: cast_nullable_to_non_nullable
              as String?,
      consumerName: freezed == consumerName
          ? _value.consumerName
          : consumerName // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      meterNo: freezed == meterNo
          ? _value.meterNo
          : meterNo // ignore: cast_nullable_to_non_nullable
              as String?,
      billAmount: freezed == billAmount
          ? _value.billAmount
          : billAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      noOfMonths: freezed == noOfMonths
          ? _value.noOfMonths
          : noOfMonths // ignore: cast_nullable_to_non_nullable
              as int?,
      lastReading: freezed == lastReading
          ? _value.lastReading
          : lastReading // ignore: cast_nullable_to_non_nullable
              as int?,
      currentReading: freezed == currentReading
          ? _value.currentReading
          : currentReading // ignore: cast_nullable_to_non_nullable
              as int?,
      remarks: freezed == remarks
          ? _value.remarks
          : remarks // ignore: cast_nullable_to_non_nullable
              as String?,
      disconnectionDate: freezed == disconnectionDate
          ? _value.disconnectionDate
          : disconnectionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      disconnectedDate: freezed == disconnectedDate
          ? _value.disconnectedDate
          : disconnectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      zoneNo: freezed == zoneNo
          ? _value.zoneNo
          : zoneNo // ignore: cast_nullable_to_non_nullable
              as int?,
      bookNo: freezed == bookNo
          ? _value.bookNo
          : bookNo // ignore: cast_nullable_to_non_nullable
              as int?,
      isConnected: freezed == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPayed: freezed == isPayed
          ? _value.isPayed
          : isPayed // ignore: cast_nullable_to_non_nullable
              as bool?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      disconnectionTeam: freezed == disconnectionTeam
          ? _value.disconnectionTeam
          : disconnectionTeam // ignore: cast_nullable_to_non_nullable
              as Team?,
      proofOfDisconnection: freezed == proofOfDisconnection
          ? _value.proofOfDisconnection
          : proofOfDisconnection // ignore: cast_nullable_to_non_nullable
              as List<ProofOfDisconnection>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TeamCopyWith<$Res>? get disconnectionTeam {
    if (_value.disconnectionTeam == null) {
      return null;
    }

    return $TeamCopyWith<$Res>(_value.disconnectionTeam!, (value) {
      return _then(_value.copyWith(disconnectionTeam: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConsumerModelImplCopyWith<$Res>
    implements $ConsumerModelCopyWith<$Res> {
  factory _$$ConsumerModelImplCopyWith(
          _$ConsumerModelImpl value, $Res Function(_$ConsumerModelImpl) then) =
      __$$ConsumerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? disconnectionId,
      String? accountNo,
      String? prevAccountNo,
      String? consumerName,
      String? address,
      String? meterNo,
      String? billAmount,
      int? noOfMonths,
      int? lastReading,
      int? currentReading,
      String? remarks,
      DateTime? disconnectionDate,
      DateTime? disconnectedDate,
      int? zoneNo,
      int? bookNo,
      bool? isConnected,
      bool? isPayed,
      int? status,
      Team? disconnectionTeam,
      List<ProofOfDisconnection>? proofOfDisconnection});

  @override
  $TeamCopyWith<$Res>? get disconnectionTeam;
}

/// @nodoc
class __$$ConsumerModelImplCopyWithImpl<$Res>
    extends _$ConsumerModelCopyWithImpl<$Res, _$ConsumerModelImpl>
    implements _$$ConsumerModelImplCopyWith<$Res> {
  __$$ConsumerModelImplCopyWithImpl(
      _$ConsumerModelImpl _value, $Res Function(_$ConsumerModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? disconnectionId = freezed,
    Object? accountNo = freezed,
    Object? prevAccountNo = freezed,
    Object? consumerName = freezed,
    Object? address = freezed,
    Object? meterNo = freezed,
    Object? billAmount = freezed,
    Object? noOfMonths = freezed,
    Object? lastReading = freezed,
    Object? currentReading = freezed,
    Object? remarks = freezed,
    Object? disconnectionDate = freezed,
    Object? disconnectedDate = freezed,
    Object? zoneNo = freezed,
    Object? bookNo = freezed,
    Object? isConnected = freezed,
    Object? isPayed = freezed,
    Object? status = freezed,
    Object? disconnectionTeam = freezed,
    Object? proofOfDisconnection = freezed,
  }) {
    return _then(_$ConsumerModelImpl(
      disconnectionId: freezed == disconnectionId
          ? _value.disconnectionId
          : disconnectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      accountNo: freezed == accountNo
          ? _value.accountNo
          : accountNo // ignore: cast_nullable_to_non_nullable
              as String?,
      prevAccountNo: freezed == prevAccountNo
          ? _value.prevAccountNo
          : prevAccountNo // ignore: cast_nullable_to_non_nullable
              as String?,
      consumerName: freezed == consumerName
          ? _value.consumerName
          : consumerName // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      meterNo: freezed == meterNo
          ? _value.meterNo
          : meterNo // ignore: cast_nullable_to_non_nullable
              as String?,
      billAmount: freezed == billAmount
          ? _value.billAmount
          : billAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      noOfMonths: freezed == noOfMonths
          ? _value.noOfMonths
          : noOfMonths // ignore: cast_nullable_to_non_nullable
              as int?,
      lastReading: freezed == lastReading
          ? _value.lastReading
          : lastReading // ignore: cast_nullable_to_non_nullable
              as int?,
      currentReading: freezed == currentReading
          ? _value.currentReading
          : currentReading // ignore: cast_nullable_to_non_nullable
              as int?,
      remarks: freezed == remarks
          ? _value.remarks
          : remarks // ignore: cast_nullable_to_non_nullable
              as String?,
      disconnectionDate: freezed == disconnectionDate
          ? _value.disconnectionDate
          : disconnectionDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      disconnectedDate: freezed == disconnectedDate
          ? _value.disconnectedDate
          : disconnectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      zoneNo: freezed == zoneNo
          ? _value.zoneNo
          : zoneNo // ignore: cast_nullable_to_non_nullable
              as int?,
      bookNo: freezed == bookNo
          ? _value.bookNo
          : bookNo // ignore: cast_nullable_to_non_nullable
              as int?,
      isConnected: freezed == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPayed: freezed == isPayed
          ? _value.isPayed
          : isPayed // ignore: cast_nullable_to_non_nullable
              as bool?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      disconnectionTeam: freezed == disconnectionTeam
          ? _value.disconnectionTeam
          : disconnectionTeam // ignore: cast_nullable_to_non_nullable
              as Team?,
      proofOfDisconnection: freezed == proofOfDisconnection
          ? _value._proofOfDisconnection
          : proofOfDisconnection // ignore: cast_nullable_to_non_nullable
              as List<ProofOfDisconnection>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsumerModelImpl implements _ConsumerModel {
  const _$ConsumerModelImpl(
      {required this.disconnectionId,
      required this.accountNo,
      required this.prevAccountNo,
      required this.consumerName,
      required this.address,
      required this.meterNo,
      required this.billAmount,
      required this.noOfMonths,
      required this.lastReading,
      required this.currentReading,
      required this.remarks,
      required this.disconnectionDate,
      required this.disconnectedDate,
      required this.zoneNo,
      required this.bookNo,
      required this.isConnected,
      required this.isPayed,
      required this.status,
      required this.disconnectionTeam,
      required final List<ProofOfDisconnection>? proofOfDisconnection})
      : _proofOfDisconnection = proofOfDisconnection;

  factory _$ConsumerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsumerModelImplFromJson(json);

  @override
  final String? disconnectionId;
  @override
  final String? accountNo;
  @override
  final String? prevAccountNo;
  @override
  final String? consumerName;
  @override
  final String? address;
  @override
  final String? meterNo;
  @override
  final String? billAmount;
  @override
  final int? noOfMonths;
  @override
  final int? lastReading;
  @override
  final int? currentReading;
  @override
  final String? remarks;
  @override
  final DateTime? disconnectionDate;
  @override
  final DateTime? disconnectedDate;
  @override
  final int? zoneNo;
  @override
  final int? bookNo;
  @override
  final bool? isConnected;
  @override
  final bool? isPayed;
  @override
  final int? status;
  @override
  final Team? disconnectionTeam;
  final List<ProofOfDisconnection>? _proofOfDisconnection;
  @override
  List<ProofOfDisconnection>? get proofOfDisconnection {
    final value = _proofOfDisconnection;
    if (value == null) return null;
    if (_proofOfDisconnection is EqualUnmodifiableListView)
      return _proofOfDisconnection;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ConsumerModel(disconnectionId: $disconnectionId, accountNo: $accountNo, prevAccountNo: $prevAccountNo, consumerName: $consumerName, address: $address, meterNo: $meterNo, billAmount: $billAmount, noOfMonths: $noOfMonths, lastReading: $lastReading, currentReading: $currentReading, remarks: $remarks, disconnectionDate: $disconnectionDate, disconnectedDate: $disconnectedDate, zoneNo: $zoneNo, bookNo: $bookNo, isConnected: $isConnected, isPayed: $isPayed, status: $status, disconnectionTeam: $disconnectionTeam, proofOfDisconnection: $proofOfDisconnection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsumerModelImpl &&
            (identical(other.disconnectionId, disconnectionId) ||
                other.disconnectionId == disconnectionId) &&
            (identical(other.accountNo, accountNo) ||
                other.accountNo == accountNo) &&
            (identical(other.prevAccountNo, prevAccountNo) ||
                other.prevAccountNo == prevAccountNo) &&
            (identical(other.consumerName, consumerName) ||
                other.consumerName == consumerName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.meterNo, meterNo) || other.meterNo == meterNo) &&
            (identical(other.billAmount, billAmount) ||
                other.billAmount == billAmount) &&
            (identical(other.noOfMonths, noOfMonths) ||
                other.noOfMonths == noOfMonths) &&
            (identical(other.lastReading, lastReading) ||
                other.lastReading == lastReading) &&
            (identical(other.currentReading, currentReading) ||
                other.currentReading == currentReading) &&
            (identical(other.remarks, remarks) || other.remarks == remarks) &&
            (identical(other.disconnectionDate, disconnectionDate) ||
                other.disconnectionDate == disconnectionDate) &&
            (identical(other.disconnectedDate, disconnectedDate) ||
                other.disconnectedDate == disconnectedDate) &&
            (identical(other.zoneNo, zoneNo) || other.zoneNo == zoneNo) &&
            (identical(other.bookNo, bookNo) || other.bookNo == bookNo) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.isPayed, isPayed) || other.isPayed == isPayed) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.disconnectionTeam, disconnectionTeam) ||
                other.disconnectionTeam == disconnectionTeam) &&
            const DeepCollectionEquality()
                .equals(other._proofOfDisconnection, _proofOfDisconnection));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        disconnectionId,
        accountNo,
        prevAccountNo,
        consumerName,
        address,
        meterNo,
        billAmount,
        noOfMonths,
        lastReading,
        currentReading,
        remarks,
        disconnectionDate,
        disconnectedDate,
        zoneNo,
        bookNo,
        isConnected,
        isPayed,
        status,
        disconnectionTeam,
        const DeepCollectionEquality().hash(_proofOfDisconnection)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsumerModelImplCopyWith<_$ConsumerModelImpl> get copyWith =>
      __$$ConsumerModelImplCopyWithImpl<_$ConsumerModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsumerModelImplToJson(
      this,
    );
  }
}

abstract class _ConsumerModel implements ConsumerModel {
  const factory _ConsumerModel(
          {required final String? disconnectionId,
          required final String? accountNo,
          required final String? prevAccountNo,
          required final String? consumerName,
          required final String? address,
          required final String? meterNo,
          required final String? billAmount,
          required final int? noOfMonths,
          required final int? lastReading,
          required final int? currentReading,
          required final String? remarks,
          required final DateTime? disconnectionDate,
          required final DateTime? disconnectedDate,
          required final int? zoneNo,
          required final int? bookNo,
          required final bool? isConnected,
          required final bool? isPayed,
          required final int? status,
          required final Team? disconnectionTeam,
          required final List<ProofOfDisconnection>? proofOfDisconnection}) =
      _$ConsumerModelImpl;

  factory _ConsumerModel.fromJson(Map<String, dynamic> json) =
      _$ConsumerModelImpl.fromJson;

  @override
  String? get disconnectionId;
  @override
  String? get accountNo;
  @override
  String? get prevAccountNo;
  @override
  String? get consumerName;
  @override
  String? get address;
  @override
  String? get meterNo;
  @override
  String? get billAmount;
  @override
  int? get noOfMonths;
  @override
  int? get lastReading;
  @override
  int? get currentReading;
  @override
  String? get remarks;
  @override
  DateTime? get disconnectionDate;
  @override
  DateTime? get disconnectedDate;
  @override
  int? get zoneNo;
  @override
  int? get bookNo;
  @override
  bool? get isConnected;
  @override
  bool? get isPayed;
  @override
  int? get status;
  @override
  Team? get disconnectionTeam;
  @override
  List<ProofOfDisconnection>? get proofOfDisconnection;
  @override
  @JsonKey(ignore: true)
  _$$ConsumerModelImplCopyWith<_$ConsumerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
