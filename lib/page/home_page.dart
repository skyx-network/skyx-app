import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:bloomskyx_app/models/profile_response_entity.dart';
import 'package:bloomskyx_app/widget/default_toast.dart';
import 'package:bloomskyx_app/widget/floating_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';

import '../common/api/api.dart';

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
  int hasPendingCheckInScore = 0;

  Future<void> fetchData() async {
    print("请求数据");
    var data = await Api().getAccountProfile();
    var checkIn = await Api().getCheckIn();
    setState(() {
      accountProfile = data;
      hasPendingCheckInScore = checkIn;
    });
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
                  OutlinedButton(
                    onPressed: () {
                      // Handle button press
                      DefaultToast.show("coming soon...");
                    },
                    child: Text(
                      'Withdraw',
                      style: TextStyle(color: Color(0xFF336352)),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Color(0xFF6da291), width: 2),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 100, 30, 10),
                    width: double.infinity,
                    child: Image.asset("assets/images/home/banner.png"),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Harvested');
                    },
                    child: Container(
                      width: 130,
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF67d8b0),
                          width: 2,
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(140, 251, 188, 1),
                            Color.fromRGBO(200, 253, 231, 1),
                            Color.fromRGBO(142, 250, 188, 1)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          "Harvested",
                          style: TextStyle(color: Color(0xFF316b4c)),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 90,
                    left: 60,
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
                        onTap: () async {
                          print("checkIn");
                          if (hasPendingCheckInScore <= 0) {
                            DefaultToast.show(
                              "Can only be harvest after 5.8 hour",
                            );
                            return;
                          }
                          print("签到");

                          _animationController.forward();
                          var reward = await Api().checkIn();
                          setState(() {
                            accountProfile!.balance.score += reward;
                          });
                        },
                        child: FloatingCircle(
                          amount: hasPendingCheckInScore,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 100,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed("/record");
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFfdf1d3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              offset: Offset(0, 1),
                              blurRadius: 10,
                            )
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Record",
                              style: TextStyle(fontSize: 15),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 14,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
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
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: Offset(0, -1),
                      spreadRadius: 1,
                      blurRadius: 15,
                    )
                  ],
                  color: Color(0xFFdffaf3)),
              height: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Coming soon...",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
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
        style: TextStyle(fontSize: 15),
      ),
      Row(
        children: [
          AnimatedFlipCounter(
            duration: Duration(milliseconds: 1000),
            value: accountProfile?.balance.score ?? 0,
            fractionDigits: 2,
            textStyle: TextStyle(
                color: Color.fromRGBO(47, 104, 85, 1),
                fontSize: 26,
                fontWeight: FontWeight.w800),
          ),
          SizedBox(
            width: 5,
          ),
          Baseline(
            baseline: 20,
            baselineType: TextBaseline.alphabetic,
            child: Text(
              "NANO",
              style: TextStyle(
                  color: Color.fromRGBO(47, 104, 85, 1), fontSize: 15),
            ),
          ),
        ],
      )
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
