import 'package:bloomskyx_app/generated/json/base/json_field.dart';
import 'package:bloomskyx_app/generated/json/score_response_entity.g.dart';
import 'dart:convert';
export 'package:bloomskyx_app/generated/json/score_response_entity.g.dart';

@JsonSerializable()
class ScoreResponseEntity {
	late int total;
	late List<ScoreResponseContent> content;

	ScoreResponseEntity();

	factory ScoreResponseEntity.fromJson(Map<String, dynamic> json) => $ScoreResponseEntityFromJson(json);

	Map<String, dynamic> toJson() => $ScoreResponseEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ScoreResponseContent {
	late String deviceSn;
	late int amount;
	late String forWhat;
	late bool income;
	late String txId;
	late String createdAt;

	ScoreResponseContent();

	factory ScoreResponseContent.fromJson(Map<String, dynamic> json) => $ScoreResponseContentFromJson(json);

	Map<String, dynamic> toJson() => $ScoreResponseContentToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}