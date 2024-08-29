import 'package:bloomskyx_app/generated/json/base/json_convert_content.dart';
import 'package:bloomskyx_app/models/checkin_info_entity_entity.dart';

CheckinInfoEntityEntity $CheckinInfoEntityEntityFromJson(
    Map<String, dynamic> json) {
  final CheckinInfoEntityEntity checkinInfoEntityEntity = CheckinInfoEntityEntity();
  final int? amount = jsonConvert.convert<int>(json['amount']);
  if (amount != null) {
    checkinInfoEntityEntity.amount = amount;
  }
  final String? nextCheckTime = jsonConvert.convert<String>(
      json['nextCheckTime']);
  if (nextCheckTime != null) {
    checkinInfoEntityEntity.nextCheckTime = nextCheckTime;
  }
  return checkinInfoEntityEntity;
}

Map<String, dynamic> $CheckinInfoEntityEntityToJson(
    CheckinInfoEntityEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['amount'] = entity.amount;
  data['nextCheckTime'] = entity.nextCheckTime;
  return data;
}

extension CheckinInfoEntityEntityExtension on CheckinInfoEntityEntity {
  CheckinInfoEntityEntity copyWith({
    int? amount,
    String? nextCheckTime,
  }) {
    return CheckinInfoEntityEntity()
      ..amount = amount ?? this.amount
      ..nextCheckTime = nextCheckTime ?? this.nextCheckTime;
  }
}