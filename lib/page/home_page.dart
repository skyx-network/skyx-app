import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:bloomskyx_app/common/logger.dart';
import 'package:bloomskyx_app/models/profile_response_entity.dart';
import 'package:bloomskyx_app/widget/default_toast.dart';
import 'package:bloomskyx_app/widget/floating_circle.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../common/api/api.dart';
import '../models/checkin_info_entity_entity.dart';

final Connectivity _connectivity = Connectivity();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _sizeAnimation;
  late Animation<Offset> _positionAnimation;

  ProfileResponseEntity? accountProfile;
  CheckinInfoEntityEntity userCheckinInfo = CheckinInfoEntityEntity();

  Future<void> fetchData() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      print("请求数据");
      var data = await Api().getAccountProfile();
      var checkinInfo = await Api().getCheckIn();
      setState(() {
        accountProfile = data;
        userCheckinInfo = checkinInfo;
      });
    } else {
      logger.i("没有授权网络连接");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
    _sizeAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
    _positionAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-0.5, -3))
            .animate(_animationController);
  }

  @override
  void dispose() {
    super.dispose();

    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> checkin() async {
      print("checkIn");
      if (userCheckinInfo.amount <= 0) {
        DateTime givenDateTime = DateTime.parse(userCheckinInfo.nextCheckTime);
        DateTime currentDateTime = DateTime.now();

        Duration difference = givenDateTime.difference(currentDateTime);
        double hoursDifference = difference.inMinutes / 60.0;
        DefaultToast.show(
          "Can only be harvest after ${hoursDifference.toStringAsFixed(1)} hour",
        );
        return;
      }
      _animationController.forward();
      var reward = await Api().checkIn();
      setState(() {
        accountProfile!.balance.score += reward;
      });
    }

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            bottom: 50, top: MediaQuery.of(context).padding.top),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(241, 254, 251, 1),
              Color.fromRGBO(208, 248, 251, 1),
              Colors.white,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Center(
                      heightFactor: 2,
                      child: Text(
                        "NANO Grants",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        Get.toNamed("/about");
                      },
                      icon: Icon(Icons.help_outline),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildGrantBalance(accountProfile),
                  //为了过审先隐藏
                  // OutlinedButton(
                  //   onPressed: () {
                  //     // Handle button press
                  //     DefaultToast.show("coming soon...");
                  //   },
                  //   child: Text(
                  //     'Withdraw',
                  //     style: TextStyle(
                  //       color: Color(0xFF336352),
                  //     ),
                  //   ),
                  //   style: OutlinedButton.styleFrom(
                  //     backgroundColor: Colors.white,
                  //     side: BorderSide(
                  //       color: Color(0xFF6da291),
                  //       width: 2,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 70, 30, 10),
                    width: double.infinity,
                    child: Image.asset("assets/images/home/banner.png"),
                  ),
                  GestureDetector(
                    onTap: checkin,
                    child: Container(
                      width: 130,
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF015678),
                          width: 2,
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(140, 221, 250, 1),
                            Color.fromRGBO(200, 238, 255, 1),
                            Color.fromRGBO(142, 221, 250, 1)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          "Harvested",
                          style: TextStyle(
                            color: Color(0xFF015678),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 110,
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        // return Opacity(
                        //   opacity: _fadeAnimation.value,
                        //   child: Transform.scale(
                        //     scale: _sizeAnimation.value,
                        //     child: FractionalTranslation(
                        //       translation: _positionAnimation.value,
                        //       child: child,
                        //     ),
                        //   ),
                        // );

                        return FractionalTranslation(
                          translation: _positionAnimation.value,
                          child: Opacity(
                            opacity: _fadeAnimation.value,
                            child: Transform.scale(
                              scale: _sizeAnimation.value,
                              child: child,
                            ),
                          ),
                        );
                      },
                      child: GestureDetector(
                        onTap: checkin,
                        child: FloatingCircle(
                          amount: userCheckinInfo.amount,
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   bottom: 100,
                  //   right: 0,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       Get.toNamed("/record");
                  //     },
                  //     child: Container(
                  //       width: 100,
                  //       height: 40,
                  //       decoration: BoxDecoration(
                  //         color: Color(0xFFfdf1d3),
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Colors.black38,
                  //             offset: Offset(0, 1),
                  //             blurRadius: 10,
                  //           )
                  //         ],
                  //         borderRadius: BorderRadius.only(
                  //           topLeft: Radius.circular(20),
                  //           bottomLeft: Radius.circular(20),
                  //         ),
                  //       ),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             "Record",
                  //             style: TextStyle(fontSize: 15),
                  //           ),
                  //           Icon(
                  //             Icons.arrow_forward_ios_outlined,
                  //             size: 14,
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: AllGrants(),
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey.withOpacity(0.3),
            //           offset: Offset(0, -1),
            //           spreadRadius: 1,
            //           blurRadius: 15,
            //         )
            //       ],
            //       color: Color(0xFFdffaf3)),
            //   height: 180,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         "Coming soon...",
            //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

Widget _buildGrantBalance(ProfileResponseEntity? accountProfile) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Grants Balance",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      Row(
        children: [
          if (accountProfile == null)
            const Text(
              "--",
              style: TextStyle(
                color: Color(0xFF015678),
                fontSize: 26,
                fontWeight: FontWeight.w800,
              ),
            ),
          if (accountProfile != null)
            AnimatedFlipCounter(
              duration: Duration(milliseconds: 1300),
              value: accountProfile.balance.score,
              fractionDigits: 2,
              textStyle: const TextStyle(
                color: Color(0xFF015678),
                fontSize: 26,
                fontWeight: FontWeight.w800,
              ),
            ),
          SizedBox(
            width: 5,
          ),
          Baseline(
            baseline: 20,
            baselineType: TextBaseline.alphabetic,
            child: Text(
              "NANO",
              style: TextStyle(color: Color(0xFF015678), fontSize: 15),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 5,
      ),
      GestureDetector(
        onTap: () {
          Get.toNamed("/record");
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Learn more ",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6a7b89),
                  fontWeight: FontWeight.w500),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFF6a7b89),
              weight: 1000,
            )
          ],
        ),
      ),
    ],
  );
}

class AllGrants extends StatelessWidget {
  const AllGrants({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "All Grants",
              style: TextStyle(fontSize: 18),
            ),
            InkWell(
              onTap: () {
                Get.toNamed("/leaderboard");
              },
              child: Container(
                padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Leaderboard',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
