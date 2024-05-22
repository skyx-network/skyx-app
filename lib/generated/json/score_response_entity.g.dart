import 'package:bloomskyx_app/generated/json/base/json_convert_content.dart';
import 'package:bloomskyx_app/models/score_response_entity.dart';

ScoreResponseEntity $ScoreResponseEntityFromJson(Map<String, dynamic> json) {
  final ScoreResponseEntity scoreResponseEntity = ScoreResponseEntity();
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    scoreResponseEntity.total = total;
  }
  final List<ScoreResponseContent>? content = (json['content'] as List<
      dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ScoreResponseContent>(e) as ScoreResponseContent)
      .toList();
  if (content != null) {
    scoreResponseEntity.content = content;
  }
  return scoreResponseEntity;
}

Map<String, dynamic> $ScoreResponseEntityToJson(ScoreResponseEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['total'] = entity.total;
  data['content'] = entity.content.map((v) => v.toJson()).toList();
  return data;
}

extension ScoreResponseEntityExtension on ScoreResponseEntity {
  ScoreResponseEntity copyWith({
    int? total,
    List<ScoreResponseContent>? content,
  }) {
    return ScoreResponseEntity()
      ..total = total ?? this.total
      ..content = content ?? this.content;
  }
}

ScoreResponseContent $ScoreResponseContentFromJson(Map<String, dynamic> json) {
  final ScoreResponseContent scoreResponseContent = ScoreResponseContent();
  final String? deviceSn = jsonConvert.convert<String>(json['deviceSn']);
  if (deviceSn != null) {
    scoreResponseContent.deviceSn = deviceSn;
  }
  final int? amount = jsonConvert.convert<int>(json['amount']);
  if (amount != null) {
    scoreResponseContent.amount = amount;
  }
  final String? forWhat = jsonConvert.convert<String>(json['forWhat']);
  if (forWhat != null) {
    scoreResponseContent.forWhat = forWhat;
  }
  final bool? income = jsonConvert.convert<bool>(json['income']);
  if (income != null) {
    scoreResponseContent.income = income;
  }
  final String? txId = jsonConvert.convert<String>(json['txId']);
  if (txId != null) {
    scoreResponseContent.txId = txId;
  }
  final String? createdAt = jsonConvert.convert<String>(json['createdAt']);
  if (createdAt != null) {
    scoreResponseContent.createdAt = createdAt;
  }
  return scoreResponseContent;
}

Map<String, dynamic> $ScoreResponseContentToJson(ScoreResponseContent entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['deviceSn'] = entity.deviceSn;
  data['amount'] = entity.amount;
  data['forWhat'] = entity.forWhat;
  data['income'] = entity.income;
  data['txId'] = entity.txId;
  data['createdAt'] = entity.createdAt;
  return data;
}

extension ScoreResponseContentExtension on ScoreResponseContent {
  ScoreResponseContent copyWith({
    String? deviceSn,
    int? amount,
    String? forWhat,
    bool? income,
    String? txId,
    String? createdAt,
  }) {
    return ScoreResponseContent()
      ..deviceSn = deviceSn ?? this.deviceSn
      ..amount = amount ?? this.amount
      ..forWhat = forWhat ?? this.forWhat
      ..income = income ?? this.income
      ..txId = txId ?? this.txId
      ..createdAt = createdAt ?? this.createdAt;
  }
}