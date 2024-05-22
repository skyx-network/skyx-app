import 'package:bloomskyx_app/generated/json/base/json_field.dart';
import 'package:bloomskyx_app/generated/json/store_account_entity.g.dart';
import 'dart:convert';
export 'package:bloomskyx_app/generated/json/store_account_entity.g.dart';

@JsonSerializable()
class StoreAccountEntity {
	late String id;
	late String email;
	late int addTime;
	late String accessToken;
	late String refreshToken;

	StoreAccountEntity();

	factory StoreAccountEntity.fromJson(Map<String, dynamic> json) => $StoreAccountEntityFromJson(json);

	Map<String, dynamic> toJson() => $StoreAccountEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}