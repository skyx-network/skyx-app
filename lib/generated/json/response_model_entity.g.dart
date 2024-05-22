import 'package:bloomskyx_app/generated/json/base/json_convert_content.dart';
import 'package:bloomskyx_app/models/response_model_entity.dart';

ResponseModelEntity $ResponseModelEntityFromJson(Map<String, dynamic> json) {
  final ResponseModelEntity responseModelEntity = ResponseModelEntity();
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    responseModelEntity.code = code;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    responseModelEntity.message = message;
  }
  final dynamic data = json['data'];
  if (data != null) {
    responseModelEntity.data = data;
  }
  return responseModelEntity;
}

Map<String, dynamic> $ResponseModelEntityToJson(ResponseModelEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['code'] = entity.code;
  data['message'] = entity.message;
  data['data'] = entity.data;
  return data;
}

extension ResponseModelEntityExtension on ResponseModelEntity {
  ResponseModelEntity copyWith({
    int? code,
    String? message,
    dynamic data,
  }) {
    return ResponseModelEntity()
      ..code = code ?? this.code
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}