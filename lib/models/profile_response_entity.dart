import 'package:bloomskyx_app/generated/json/base/json_field.dart';
import 'package:bloomskyx_app/generated/json/profile_response_entity.g.dart';
import 'dart:convert';
export 'package:bloomskyx_app/generated/json/profile_response_entity.g.dart';

@JsonSerializable()
class ProfileResponseEntity {
	late String id;
	late String email;
	late ProfileResponseTotalEarning totalEarning;
	late ProfileResponseBalance balance;
	late String createdAt;
	late String updatedAt;

	ProfileResponseEntity();

	factory ProfileResponseEntity.fromJson(Map<String, dynamic> json) => $ProfileResponseEntityFromJson(json);

	Map<String, dynamic> toJson() => $ProfileResponseEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ProfileResponseTotalEarning {
	late int score;

	ProfileResponseTotalEarning();

	factory ProfileResponseTotalEarning.fromJson(Map<String, dynamic> json) => $ProfileResponseTotalEarningFromJson(json);

	Map<String, dynamic> toJson() => $ProfileResponseTotalEarningToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ProfileResponseBalance {
	late int score;
	late int usdc;

	ProfileResponseBalance();

	factory ProfileResponseBalance.fromJson(Map<String, dynamic> json) => $ProfileResponseBalanceFromJson(json);

	Map<String, dynamic> toJson() => $ProfileResponseBalanceToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}