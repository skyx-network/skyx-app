import 'package:bloomskyx_app/generated/json/base/json_field.dart';
import 'package:bloomskyx_app/generated/json/leaderboard_response_entity.g.dart';
import 'dart:convert';
export 'package:bloomskyx_app/generated/json/leaderboard_response_entity.g.dart';

@JsonSerializable()
class LeaderboardResponseEntity {
	late List<LeaderboardResponseRank> rank;
	late LeaderboardResponseMe me;

	LeaderboardResponseEntity();

	factory LeaderboardResponseEntity.fromJson(Map<String, dynamic> json) => $LeaderboardResponseEntityFromJson(json);

	Map<String, dynamic> toJson() => $LeaderboardResponseEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class LeaderboardResponseRank {
	late int index;
	late String email;
	late int amount;

	LeaderboardResponseRank();

	factory LeaderboardResponseRank.fromJson(Map<String, dynamic> json) => $LeaderboardResponseRankFromJson(json);

	Map<String, dynamic> toJson() => $LeaderboardResponseRankToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class LeaderboardResponseMe {
	late int index;
	late String email;
	late int amount;

	LeaderboardResponseMe();

	factory LeaderboardResponseMe.fromJson(Map<String, dynamic> json) => $LeaderboardResponseMeFromJson(json);

	Map<String, dynamic> toJson() => $LeaderboardResponseMeToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}