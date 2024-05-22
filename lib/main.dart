import 'package:bloomskyx_app/common/api/api.dart';
import 'package:bloomskyx_app/page/about.dart';
import 'package:bloomskyx_app/page/device.dart';
import 'package:bloomskyx_app/page/explorer.dart';
import 'package:bloomskyx_app/page/home_page.dart';
import 'package:bloomskyx_app/page/leaderboard.dart';
import 'package:bloomskyx_app/page/login.dart';
import 'package:bloomskyx_app/page/personal.dart';
import 'package:bloomskyx_app/page/record.dart';
import 'package:bloomskyx_app/page/register.dart';
import 'package:bloomskyx_app/page/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import 'common/icon/bottom_nav_bar.dart';
import 'common/store.dart';
import 'curved_navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 初始化 Flutter 绑定

  await Store.init();
  var currentAccount = store.getCurrentAccount();
  if (currentAccount != null) {
    Api().setAuth(currentAccount.accessToken);
    // Api().setAuth("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MTU4NDUzNjAsInBheWxvYWQiOnsiZW1haWwiOiI3NzQxMzk4MTNAcXEuY29tIiwiaWQiOiI3OWI2OTY1ZWRlZDk0YTkwYjE4M2FhODg4MjJhYTMzZSIsInJvbGUiOiJjdXN0b21lciIsInR5cGUiOiJ4LWFjY2VzcyJ9fQ.E_cjNW6ouKCjaahNALMnN65ugBsbwPMsjcDYCJIG7uI");
  }
  // store.clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //判断一个路由是否是非登陆状态可以进入的
  bool isNoRequiredLoginRoute(route) {
    List<String> whiteRoutes = ["/login", "/register"];
    if (whiteRoutes.contains(route)) {
      return true;
    }
    return false;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: GetMaterialApp(
        title: 'BloomskyX',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
        // initialRoute: "/",
        getPages: [
          GetPage(name: "/", page: () => MyHomePage()),
          GetPage(name: "/register", page: () => RegisterPage()),
          GetPage(name: "/login", page: () => LoginPage()),
          GetPage(name: "/record", page: () => RecordPage()),
          GetPage(name: "/leaderboard", page: () => Leaderboard()),
          GetPage(name: "/setting", page: () => SettingPage()),
          GetPage(name: "/about", page: () => AboutPage()),
        ],
        routingCallback: (routing) {
          bool isLogin = store.getCurrentAccount() != null;
          //
          // print(store.getCurrentAccount());
          // print("没登录:${!isLogin}");
          // print("目标地址:${routing?.current}");
          // print(
          //     "isNoRequiredLoginRoute:${!isNoRequiredLoginRoute(routing?.current)}");
          if (!isLogin && !isNoRequiredLoginRoute(routing?.current)) {
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              // print("跳转到login");
              Get.offAllNamed("/login");
            });
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _navIndex = 0;
  late PageController _pageController;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _navIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [HomePage(), DevicePage(), ExplorerPage(), PersonalPage()],
      ),
      bottomNavigationBar: Container(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildBottomNavigationBar(context),
          Container(
            height: MediaQuery.of(context).padding.bottom,
            color: Colors.white,
          )
        ],
      )),
    );
  }

  Widget buildBottomNavigationBar(BuildContext context) {
    Color defaultColor = Color.fromRGBO(127, 127, 127, 1);
    TextStyle buildTextStyle(i) {
      Color c = defaultColor;
      if (i == _navIndex) {
        c = Colors.white;
      }
      return TextStyle(fontSize: 12, color: c);
    }

    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: 0,
      height: 75.0,
      items: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              BottomNavBar.home,
              size: 26,
              color: _navIndex == 0 ? Colors.white : defaultColor,
            ),
            Text(
              "Home",
              style: buildTextStyle(0),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              BottomNavBar.device,
              size: 26,
              color: _navIndex == 1 ? Colors.white : defaultColor,
            ),
            Text(
              "Device",
              style: buildTextStyle(1),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _navIndex == 2
                  ? BottomNavBar.explorerFull
                  : BottomNavBar.explorer,
              size: 26,
              color: _navIndex == 2 ? Colors.white : defaultColor,
            ),
            Text(
              "Explorer",
              style: buildTextStyle(2),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              BottomNavBar.personal,
              size: 26,
              color: _navIndex == 3 ? Colors.white : defaultColor,
            ),
            Text(
              "Personal",
              style: buildTextStyle(3),
            )
          ],
        ),
      ],
      color: Colors.white,
      buttonBackgroundColor: Color.fromRGBO(32, 187, 156, 1),
      backgroundColor: Colors.black,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 300),
      onTap: (index) {
        _pageController.jumpToPage(index);
        setState(() {
          _navIndex = index;
        });
      },
      letIndexChange: (index) => true,
    );
  }
}
