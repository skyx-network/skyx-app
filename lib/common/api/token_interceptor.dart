import 'package:bloomskyx_app/common/store.dart';
import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';

import '../logger.dart';

class TokenInterceptor extends Interceptor {
  final Dio dio;
  final Future<String> Function() refreshTokenCall; // 这应该是一个返回新Token的异步方法

  TokenInterceptor({required this.dio, required this.refreshTokenCall});

  final whiteList = [
    "/api/v1/user/login",
    "/api/v1/user/registerCode",
    "/api/v1/user/register",
    "/api/v1/user/refreshToken",
    "/api/v1/user/password/resetEmail"
  ];

  bool isWhiteListUrl(String url) {
    for (url in whiteList) {
      return url.startsWith(url);
    }

    return false;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print(options.path);
    //请求地址如果不是白名单的而且未登录的话，就跳转到登录页面
    if (!isWhiteListUrl(options.path)) {
      final currentAccount = store.getCurrentAccount();

      if (options.headers["Authorization"] == null ||
          options.headers["Authorization"] == "") {
        if (currentAccount == null) {
          print("拦截器onRequest中跳转login");
          Get.offAllNamed("/login");
          return;
        }
        //如果记录了登录的账号，就加上token
        options.headers["Authorization"] = currentAccount.accessToken;
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print("token onError:${err.response}");
    // logger.i(err.requestOptions.path);
    if (err.response?.statusCode == 401 &&
        err.requestOptions.path != "/api/v1/user/login") {
      try {
        final opts = err.requestOptions;

        // 调用刷新Token的API
        var newToken = await refreshTokenCall();

        dio.options.headers["Authorization"] =
            newToken; //更新dio对象中的Authorization
        opts.headers["Authorization"] =
            newToken; //更新401请求headers中的Authorization
        store.updateCurrentAccountAccessToken(newToken); //更新存储中的Authorization
        final retryResp = await dio.fetch(opts);
        return handler.resolve(retryResp);
      } catch (e) {
        //刷新token失败，可能时网络问题，也可能时refreshToken失效，让用户去登录
        print("拦截器onError中跳转login");
        return Get.toNamed("/login");
      }
    }
    // 其他错误直接传递
    handler.next(err);
  }
}
