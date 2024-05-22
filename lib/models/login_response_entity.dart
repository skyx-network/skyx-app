import 'package:bloomskyx_app/generated/json/base/json_field.dart';
import 'package:bloomskyx_app/generated/json/login_response_entity.g.dart';
import 'dart:convert';
export 'package:bloomskyx_app/generated/json/login_response_entity.g.dart';

@JsonSerializable()
class LoginResponseEntity {
	late LoginResponseUser user;
	late String accessToken;
	late String refreshToken;

	LoginResponseEntity();

	factory LoginResponseEntity.fromJson(Map<String, dynamic> json) => $LoginResponseEntityFromJson(json);

	Map<String, dynamic> toJson() => $LoginResponseEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class LoginResponseUser {
	late String id;
	late String email;
	late String createdAt;
	late String updatedAt;

	LoginResponseUser();

	factory LoginResponseUser.fromJson(Map<String, dynamic> json) => $LoginResponseUserFromJson(json);

	Map<String, dynamic> toJson() => $LoginResponseUserToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}