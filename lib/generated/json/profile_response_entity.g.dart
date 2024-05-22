import 'package:bloomskyx_app/generated/json/base/json_convert_content.dart';
import 'package:bloomskyx_app/models/profile_response_entity.dart';

ProfileResponseEntity $ProfileResponseEntityFromJson(
    Map<String, dynamic> json) {
  final ProfileResponseEntity profileResponseEntity = ProfileResponseEntity();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    profileResponseEntity.id = id;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    profileResponseEntity.email = email;
  }
  final ProfileResponseTotalEarning? totalEarning = jsonConvert.convert<
      ProfileResponseTotalEarning>(json['totalEarning']);
  if (totalEarning != null) {
    profileResponseEntity.totalEarning = totalEarning;
  }
  final ProfileResponseBalance? balance = jsonConvert.convert<
      ProfileResponseBalance>(json['balance']);
  if (balance != null) {
    profileResponseEntity.balance = balance;
  }
  final String? createdAt = jsonConvert.convert<String>(json['createdAt']);
  if (createdAt != null) {
    profileResponseEntity.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updatedAt']);
  if (updatedAt != null) {
    profileResponseEntity.updatedAt = updatedAt;
  }
  return profileResponseEntity;
}

Map<String, dynamic> $ProfileResponseEntityToJson(
    ProfileResponseEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['email'] = entity.email;
  data['totalEarning'] = entity.totalEarning.toJson();
  data['balance'] = entity.balance.toJson();
  data['createdAt'] = entity.createdAt;
  data['updatedAt'] = entity.updatedAt;
  return data;
}

extension ProfileResponseEntityExtension on ProfileResponseEntity {
  ProfileResponseEntity copyWith({
    String? id,
    String? email,
    ProfileResponseTotalEarning? totalEarning,
    ProfileResponseBalance? balance,
    String? createdAt,
    String? updatedAt,
  }) {
    return ProfileResponseEntity()
      ..id = id ?? this.id
      ..email = email ?? this.email
      ..totalEarning = totalEarning ?? this.totalEarning
      ..balance = balance ?? this.balance
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt;
  }
}

ProfileResponseTotalEarning $ProfileResponseTotalEarningFromJson(
    Map<String, dynamic> json) {
  final ProfileResponseTotalEarning profileResponseTotalEarning = ProfileResponseTotalEarning();
  final int? score = jsonConvert.convert<int>(json['score']);
  if (score != null) {
    profileResponseTotalEarning.score = score;
  }
  return profileResponseTotalEarning;
}

Map<String, dynamic> $ProfileResponseTotalEarningToJson(
    ProfileResponseTotalEarning entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['score'] = entity.score;
  return data;
}

extension ProfileResponseTotalEarningExtension on ProfileResponseTotalEarning {
  ProfileResponseTotalEarning copyWith({
    int? score,
  }) {
    return ProfileResponseTotalEarning()
      ..score = score ?? this.score;
  }
}

ProfileResponseBalance $ProfileResponseBalanceFromJson(
    Map<String, dynamic> json) {
  final ProfileResponseBalance profileResponseBalance = ProfileResponseBalance();
  final int? score = jsonConvert.convert<int>(json['score']);
  if (score != null) {
    profileResponseBalance.score = score;
  }
  final int? usdc = jsonConvert.convert<int>(json['usdc']);
  if (usdc != null) {
    profileResponseBalance.usdc = usdc;
  }
  return profileResponseBalance;
}

Map<String, dynamic> $ProfileResponseBalanceToJson(
    ProfileResponseBalance entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['score'] = entity.score;
  data['usdc'] = entity.usdc;
  return data;
}

extension ProfileResponseBalanceExtension on ProfileResponseBalance {
  ProfileResponseBalance copyWith({
    int? score,
    int? usdc,
  }) {
    return ProfileResponseBalance()
      ..score = score ?? this.score
      ..usdc = usdc ?? this.usdc;
  }
}