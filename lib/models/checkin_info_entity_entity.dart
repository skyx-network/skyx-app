import 'package:bloomskyx_app/generated/json/base/json_field.dart';
import 'package:bloomskyx_app/generated/json/checkin_info_entity_entity.g.dart';
import 'dart:convert';
export 'package:bloomskyx_app/generated/json/checkin_info_entity_entity.g.dart';

@JsonSerializable()
class CheckinInfoEntityEntity {
  late int amount;
  late String nextCheckTime;

  CheckinInfoEntityEntity({int? amount, String? nextCheckTime}) {
    this.amount = amount ?? 0;
    this.nextCheckTime = nextCheckTime ?? '';
  }

  factory CheckinInfoEntityEntity.fromJson(Map<String, dynamic> json) =>
      $CheckinInfoEntityEntityFromJson(json);

  Map<String, dynamic> toJson() => $CheckinInfoEntityEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
