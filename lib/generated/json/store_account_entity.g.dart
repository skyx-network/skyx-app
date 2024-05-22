import 'package:bloomskyx_app/generated/json/base/json_convert_content.dart';
import 'package:bloomskyx_app/models/store_account_entity.dart';

StoreAccountEntity $StoreAccountEntityFromJson(Map<String, dynamic> json) {
  final StoreAccountEntity storeAccountEntity = StoreAccountEntity();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    storeAccountEntity.id = id;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    storeAccountEntity.email = email;
  }
  final int? addTime = jsonConvert.convert<int>(json['addTime']);
  if (addTime != null) {
    storeAccountEntity.addTime = addTime;
  }
  final String? accessToken = jsonConvert.convert<String>(json['accessToken']);
  if (accessToken != null) {
    storeAccountEntity.accessToken = accessToken;
  }
  final String? refreshToken = jsonConvert.convert<String>(
      json['refreshToken']);
  if (refreshToken != null) {
    storeAccountEntity.refreshToken = refreshToken;
  }
  return storeAccountEntity;
}

Map<String, dynamic> $StoreAccountEntityToJson(StoreAccountEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['email'] = entity.email;
  data['addTime'] = entity.addTime;
  data['accessToken'] = entity.accessToken;
  data['refreshToken'] = entity.refreshToken;
  return data;
}

extension StoreAccountEntityExtension on StoreAccountEntity {
  StoreAccountEntity copyWith({
    String? id,
    String? email,
    int? addTime,
    String? accessToken,
    String? refreshToken,
  }) {
    return StoreAccountEntity()
      ..id = id ?? this.id
      ..email = email ?? this.email
      ..addTime = addTime ?? this.addTime
      ..accessToken = accessToken ?? this.accessToken
      ..refreshToken = refreshToken ?? this.refreshToken;
  }
}