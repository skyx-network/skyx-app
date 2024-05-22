import 'package:bloomskyx_app/generated/json/base/json_convert_content.dart';
import 'package:bloomskyx_app/models/login_response_entity.dart';

LoginResponseEntity $LoginResponseEntityFromJson(Map<String, dynamic> json) {
  final LoginResponseEntity loginResponseEntity = LoginResponseEntity();
  final LoginResponseUser? user = jsonConvert.convert<LoginResponseUser>(
      json['user']);
  if (user != null) {
    loginResponseEntity.user = user;
  }
  final String? accessToken = jsonConvert.convert<String>(json['accessToken']);
  if (accessToken != null) {
    loginResponseEntity.accessToken = accessToken;
  }
  final String? refreshToken = jsonConvert.convert<String>(
      json['refreshToken']);
  if (refreshToken != null) {
    loginResponseEntity.refreshToken = refreshToken;
  }
  return loginResponseEntity;
}

Map<String, dynamic> $LoginResponseEntityToJson(LoginResponseEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['user'] = entity.user.toJson();
  data['accessToken'] = entity.accessToken;
  data['refreshToken'] = entity.refreshToken;
  return data;
}

extension LoginResponseEntityExtension on LoginResponseEntity {
  LoginResponseEntity copyWith({
    LoginResponseUser? user,
    String? accessToken,
    String? refreshToken,
  }) {
    return LoginResponseEntity()
      ..user = user ?? this.user
      ..accessToken = accessToken ?? this.accessToken
      ..refreshToken = refreshToken ?? this.refreshToken;
  }
}

LoginResponseUser $LoginResponseUserFromJson(Map<String, dynamic> json) {
  final LoginResponseUser loginResponseUser = LoginResponseUser();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    loginResponseUser.id = id;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    loginResponseUser.email = email;
  }
  final String? createdAt = jsonConvert.convert<String>(json['createdAt']);
  if (createdAt != null) {
    loginResponseUser.createdAt = createdAt;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updatedAt']);
  if (updatedAt != null) {
    loginResponseUser.updatedAt = updatedAt;
  }
  return loginResponseUser;
}

Map<String, dynamic> $LoginResponseUserToJson(LoginResponseUser entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['email'] = entity.email;
  data['createdAt'] = entity.createdAt;
  data['updatedAt'] = entity.updatedAt;
  return data;
}

extension LoginResponseUserExtension on LoginResponseUser {
  LoginResponseUser copyWith({
    String? id,
    String? email,
    String? createdAt,
    String? updatedAt,
  }) {
    return LoginResponseUser()
      ..id = id ?? this.id
      ..email = email ?? this.email
      ..createdAt = createdAt ?? this.createdAt
      ..updatedAt = updatedAt ?? this.updatedAt;
  }
}