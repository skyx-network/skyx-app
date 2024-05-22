import 'package:bloomskyx_app/generated/json/base/json_field.dart';
import 'package:bloomskyx_app/generated/json/response_model_entity.g.dart';
import 'dart:convert';
export 'package:bloomskyx_app/generated/json/response_model_entity.g.dart';

@JsonSerializable()
class ResponseModelEntity {
	late int code;
	late String message;
	dynamic data;

	ResponseModelEntity();

	factory ResponseModelEntity.fromJson(Map<String, dynamic> json) => $ResponseModelEntityFromJson(json);

	Map<String, dynamic> toJson() => $ResponseModelEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}