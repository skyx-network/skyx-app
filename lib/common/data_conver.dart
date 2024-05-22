import 'package:bloomskyx_app/models/login_response_entity.dart';
import 'package:bloomskyx_app/models/store_account_entity.dart';

class DataCover {
  static StoreAccountEntity toStoreAccount(LoginResponseEntity response) {
    var jsonMap = {
      "id": response.user.id,
      "email": response.user.email,
      "addTime": DateTime.now().millisecondsSinceEpoch, //当前设备首次登录的时间，主要用作排序
      "accessToken": response.accessToken,
      "refreshToken": response.refreshToken,
    };

    return StoreAccountEntity.fromJson(jsonMap);
  }

  static LoginResponseEntity toLoginResponse(
      StoreAccountEntity storeAccountEntity) {
    var jsonMap = {
      "user": {
        "id": storeAccountEntity.id,
        "email": storeAccountEntity.email,
        "createdAt": "",
        "updatedAt": ""
      },
      "accessToken": storeAccountEntity.accessToken,
      "refreshToken": storeAccountEntity.refreshToken
    };

    return LoginResponseEntity.fromJson(jsonMap);
  }
}
