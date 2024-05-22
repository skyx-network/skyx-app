import 'package:bloomskyx_app/generated/json/base/json_convert_content.dart';
import 'package:bloomskyx_app/models/leaderboard_response_entity.dart';

LeaderboardResponseEntity $LeaderboardResponseEntityFromJson(
    Map<String, dynamic> json) {
  final LeaderboardResponseEntity leaderboardResponseEntity = LeaderboardResponseEntity();
  final List<LeaderboardResponseRank>? rank = (json['rank'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<LeaderboardResponseRank>(
          e) as LeaderboardResponseRank)
      .toList();
  if (rank != null) {
    leaderboardResponseEntity.rank = rank;
  }
  final LeaderboardResponseMe? me = jsonConvert.convert<LeaderboardResponseMe>(
      json['me']);
  if (me != null) {
    leaderboardResponseEntity.me = me;
  }
  return leaderboardResponseEntity;
}

Map<String, dynamic> $LeaderboardResponseEntityToJson(
    LeaderboardResponseEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['rank'] = entity.rank.map((v) => v.toJson()).toList();
  data['me'] = entity.me.toJson();
  return data;
}

extension LeaderboardResponseEntityExtension on LeaderboardResponseEntity {
  LeaderboardResponseEntity copyWith({
    List<LeaderboardResponseRank>? rank,
    LeaderboardResponseMe? me,
  }) {
    return LeaderboardResponseEntity()
      ..rank = rank ?? this.rank
      ..me = me ?? this.me;
  }
}

LeaderboardResponseRank $LeaderboardResponseRankFromJson(
    Map<String, dynamic> json) {
  final LeaderboardResponseRank leaderboardResponseRank = LeaderboardResponseRank();
  final int? index = jsonConvert.convert<int>(json['index']);
  if (index != null) {
    leaderboardResponseRank.index = index;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    leaderboardResponseRank.email = email;
  }
  final int? amount = jsonConvert.convert<int>(json['amount']);
  if (amount != null) {
    leaderboardResponseRank.amount = amount;
  }
  return leaderboardResponseRank;
}

Map<String, dynamic> $LeaderboardResponseRankToJson(
    LeaderboardResponseRank entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['index'] = entity.index;
  data['email'] = entity.email;
  data['amount'] = entity.amount;
  return data;
}

extension LeaderboardResponseRankExtension on LeaderboardResponseRank {
  LeaderboardResponseRank copyWith({
    int? index,
    String? email,
    int? amount,
  }) {
    return LeaderboardResponseRank()
      ..index = index ?? this.index
      ..email = email ?? this.email
      ..amount = amount ?? this.amount;
  }
}

LeaderboardResponseMe $LeaderboardResponseMeFromJson(
    Map<String, dynamic> json) {
  final LeaderboardResponseMe leaderboardResponseMe = LeaderboardResponseMe();
  final int? index = jsonConvert.convert<int>(json['index']);
  if (index != null) {
    leaderboardResponseMe.index = index;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    leaderboardResponseMe.email = email;
  }
  final int? amount = jsonConvert.convert<int>(json['amount']);
  if (amount != null) {
    leaderboardResponseMe.amount = amount;
  }
  return leaderboardResponseMe;
}

Map<String, dynamic> $LeaderboardResponseMeToJson(
    LeaderboardResponseMe entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['index'] = entity.index;
  data['email'] = entity.email;
  data['amount'] = entity.amount;
  return data;
}

extension LeaderboardResponseMeExtension on LeaderboardResponseMe {
  LeaderboardResponseMe copyWith({
    int? index,
    String? email,
    int? amount,
  }) {
    return LeaderboardResponseMe()
      ..index = index ?? this.index
      ..email = email ?? this.email
      ..amount = amount ?? this.amount;
  }
}