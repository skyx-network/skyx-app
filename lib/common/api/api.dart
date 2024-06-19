import 'dart:convert';

import 'package:bloomskyx_app/common/store.dart';
import 'package:bloomskyx_app/models/leaderboard_response_entity.dart';
import 'package:bloomskyx_app/models/login_response_entity.dart';
import 'package:bloomskyx_app/models/profile_response_entity.dart';
import 'package:bloomskyx_app/models/response_model_entity.dart';
import 'package:bloomskyx_app/models/score_response_entity.dart';
import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';

import '../../models/store_account_entity.dart';
import '../../widget/default_toast.dart';
import 'token_interceptor.dart';

class Api {
  static final Api _singleton = Api._internal();

  // final String baseUrl = "https://test-bsx-svc.xdata.net";
  final String baseUrl = "https://skyxglobal.com";
  late Dio dio;

  factory Api() {
    return _singleton;
  }

  Api._internal() {
    dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.contentType = Headers.jsonContentType;

    dio.interceptors.add(TokenInterceptor(
      dio: dio,
      refreshTokenCall: refreshToken,
    ));
    // 初始化Log拦截器
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  Future<ResponseModelEntity> http(String method, String url,
      {Object? body, Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await dio.request(url,
          options: Options(method: method),
          data: body,
          queryParameters: queryParameters);
      var res = jsonDecode(response.toString());
      return ResponseModelEntity.fromJson(res);
    } catch (e) {
      if (e is DioException) {
        var res = e.response;
        if (res?.statusCode == 400) {
          var resMap = jsonDecode(res.toString());
          if (resMap["code"] == 701) {
            DefaultToast.show('Access too frequent, please wait a moment.',
                type: DefaultToastType.Error);
          }
          if (resMap["code"] == 702) {
            DefaultToast.show('Entity already exists',
                type: DefaultToastType.Error);
          }
        } else if (res?.statusCode != 200) {
          DefaultToast.show('Unknown error (${res?.statusCode})');
        }
      } else {
        DefaultToast.show('Unknown error');
      }
      rethrow;
    }
  }

  void setAuth(String token) {
    dio.options.headers = {
      "Authorization": token,
    };
  }

  Future<void> sendVerifyCode(String email) async {
    ResponseModelEntity response =
        await http("post", "/api/v1/user/registerCode?email=$email");
    if (response.code == 701) {
      print("发送太多次了，请稍后重试");
    }
  }

  Future<void> sendResetPasswordEmail(String email) async {
    ResponseModelEntity response = await http(
        "post", "/api/v1/user/password/resetEmail",
        body: {"email": email});
    if (response.code == 701) {
      print("发送太多次了，请稍后重试");
    }
  }

  Future<void> register(String code, String email, String password) async {
    await http("post", "/api/v1/user/register",
        body: {"code": code, "email": email, "password": password});
  }

  Future<void> deleteAccount() async {
    await http("delete", "/api/v1/user/myAccount");
  }

  Future<LoginResponseEntity> login(String email, String password) async {
    ResponseModelEntity response = await http("post", "/api/v1/user/login",
        body: {"email": email, "password": password});
    return LoginResponseEntity.fromJson(response.data);
  }

  Future<LeaderboardResponseEntity> getLeaderboardInfo(
      {int limit = 10, int? from, int? to}) async {
    var query = {"limit": limit};
    if (from != null) {
      query["from"] = from;
    }
    if (to != null) {
      query["to"] = to;
    }
    ResponseModelEntity response =
        await http("get", "/api/v1/score/rank", queryParameters: query);
    return LeaderboardResponseEntity.fromJson(response.data);
  }

  Future<ProfileResponseEntity> getAccountProfile() async {
    ResponseModelEntity response = await http("get", "/api/v1/user/profile");

    return ProfileResponseEntity.fromJson(response.data);
  }

  Future<ScoreResponseEntity> getScores() async {
    ResponseModelEntity response = await http("get", "/api/v1/score",
        queryParameters: {"income": true, "forWhat": "checkin"});

    return ScoreResponseEntity.fromJson(response.data);
  }

  Future<String> refreshToken() async {
    print("refreshToken");
    StoreAccountEntity? currentAccount = store.getCurrentAccount();
    if (currentAccount == null) {
      //如果当前没有登录过的账户，就让用户去登录
      print("refreshToken中跳转login");
      Get.toNamed("/login");
    }

    var tokenDio = Dio();
    tokenDio.options.method = "post";
    tokenDio.options.baseUrl = baseUrl;
    tokenDio.options.headers = {
      "Authorization": currentAccount!.refreshToken,
    };
    tokenDio.interceptors
        .add(LogInterceptor(responseBody: true, requestBody: true));

    Response response = await tokenDio.request("/api/v1/user/refreshToken");
    var res = jsonDecode(response.toString());
    var responseModel = ResponseModelEntity.fromJson(res);
    return responseModel.data["accessToken"];
  }

  Future<int> getCheckIn() async {
    ResponseModelEntity response = await http("get", "/api/v1/score/checkin");
    return response.data["amount"];
  }

  Future<int> checkIn() async {
    ResponseModelEntity response = await http("post", "/api/v1/score/checkin");
    return response.data["rewardedAmount"];
  }
}
