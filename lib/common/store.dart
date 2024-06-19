import 'dart:convert';

import 'package:bloomskyx_app/common/data_conver.dart';
import 'package:bloomskyx_app/models/login_response_entity.dart';
import 'package:bloomskyx_app/models/store_account_entity.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Store {
  static final Store _instance = Store._internal();

  // 保持一个sp的引用
  static late final SharedPreferences _sharedPreferences;

  // 获取单例
  factory Store() {
    return _instance;
  }

  Store._internal();

  // 初始化SharedPreferences实例
  static Future<void> init() async {
    print("初始化数据库");
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void setIfNull<T>(String key, T value) {
    //如果保存的key存在并且key对应的value不为null的话，直接return不保存了
    if (_sharedPreferences.containsKey(key) &&
        _sharedPreferences.get(key) != null) {
      return;
    }

    set(key, value);
  }

  Future<bool> set<T>(String key, T value) async {
    Type type = value.runtimeType;
    // print("set type: $type" );
    switch (type) {
      case String:
        return _sharedPreferences.setString(key, value as String);
      case int:
        return _sharedPreferences.setInt(key, value as int);
      case bool:
        return _sharedPreferences.setBool(key, value as bool);
      case double:
        return _sharedPreferences.setDouble(key, value as double);
    }

    if (value is List<String>) {
      return _sharedPreferences.setStringList(key, value);
    }

    if (value is Map) {
      // map，转成json格式的字符串进行保存。序列化成json字符串
      return _sharedPreferences.setString(key, json.encode(value));
    }

    throw ("未知的类型，不支持存储");
  }

  Object? get<T>(String key) {
    var value = _sharedPreferences.get(key);
    // if (value is String) {
    //   try {
    //     // 反序列化，处理map，原样返回map回去。
    //     return const JsonDecoder().convert(value) as Map<String, dynamic>;
    //   } on FormatException catch (e) {
    //     return value; // 返回字符串
    //   }
    // }
    return value;
  }

  Future<bool> remove(String key) {
    return _sharedPreferences.remove(key);
  }

  Future<bool> clear() {
    return _sharedPreferences.clear();
  }

  bool check(String key) {
    return get(key) != null;
  }

  List<StoreAccountEntity> getAccounts() {
    var data = _sharedPreferences.getStringList("_Accounts");
    if (data == null) {
      return [];
    }

    return data.map((string) {
      Map<String, dynamic> jsonMap = jsonDecode(string);
      return StoreAccountEntity.fromJson(jsonMap);
    }).toList();
  }

  Future<void> deleteAccount(StoreAccountEntity? accountEntity) async {
    if (accountEntity == null) {
      return;
    }
    var accounts = getAccounts();
    if (accounts.isEmpty) {
      return;
    }
    print("first accounts: $accounts");
    var findAccount =
        accounts.firstWhereOrNull((account) => account.id == accountEntity.id);
    // if (findAccount == null) {
    //   return;
    // }
    accounts.remove(findAccount);
    print("after remove accounts: $accounts");
    await _sharedPreferences.setStringList(
        "_Accounts", accounts.map((e) => e.toString()).toList());
  }

  //添加一个用户到存储中
  Future<void> addAccount(LoginResponseEntity response) async {
    try {
      var currentAccounts = getAccounts();

      Map<String, StoreAccountEntity> accountMap = {};
      for (var element in currentAccounts) {
        accountMap[element.id] = element;
      }
      if (accountMap[response.user.id] != null) {
        accountMap[response.user.id]!.accessToken = response.accessToken;
        accountMap[response.user.id]!.refreshToken = response.refreshToken;
        accountMap[response.user.id]!.email = response.user.email;
      } else {
        accountMap[response.user.id] = DataCover.toStoreAccount(response);
      }

      var list = accountMap.values.map((e) => e.toString()).toList();
      await _sharedPreferences.setStringList("_Accounts", list);
      //设置当前的用户是谁
      await setCurrentAccount(accountMap[response.user.id]!);
    } catch (e) {
      printError(info: e.toString());
      rethrow;
    }
  }

  Future<bool> setCurrentAccount(StoreAccountEntity storeAccountEntity) async {
    return _sharedPreferences.setString(
      "_Current_Accounts",
      jsonEncode(
        storeAccountEntity.toJson(),
      ),
    );
  }

  Future<bool> removeCurrentAccount() {
    return _sharedPreferences.remove("_Current_Accounts");
  }

  StoreAccountEntity? getCurrentAccount() {
    var data = _sharedPreferences.getString("_Current_Accounts");

    if (data != null) {
      return StoreAccountEntity.fromJson(jsonDecode(data));
    }
    return null;
  }

  void updateCurrentAccountAccessToken(String accessToken) {
    final currentAccount = getCurrentAccount();
    if (currentAccount == null) {
      return;
    }

    currentAccount.accessToken = accessToken;
    addAccount(DataCover.toLoginResponse(currentAccount));
  }
}

// 全局可用的单例
final store = Store();
