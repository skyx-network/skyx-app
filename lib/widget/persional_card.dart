import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/profile_response_entity.dart';

class PersionalCard extends StatelessWidget {
  PersionalCard({super.key, required this.data});

  final ProfileResponseEntity? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 270,
      padding: EdgeInsets.symmetric(horizontal: 20),
      // color: Colors.blue,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 230,
            child: Container(
              // padding: EdgeInsets.symmetric(vertical: 20),
              // margin: EdgeInsets.symmetric(horizontal: 20),
              // height: 230,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: Offset(0, -2),
                    spreadRadius: 1,
                    blurRadius: 20,
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/avatar/avatar_1.webp",
                  ),
                  minRadius: 40,
                  maxRadius: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.email_outlined,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(data?.email ?? "-"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Opacity(
                  opacity: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Color(0xFF6e9bc5),
                        borderRadius: BorderRadius.circular(25)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text(
                            "CA8694C5802140B6ABC080410D01C3ADC080410D01",
                            overflow: TextOverflow.ellipsis, // 使用省略号来处理溢出文本
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildWalletData("Balance", data?.balance.score ?? 0),
                      Container(
                        width: 2,
                        height: 40,
                        color: Color(0xFFf2f2f2),
                      ),
                      _buildWalletData(
                          "Total Earning", data?.totalEarning.score ?? 0)
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWalletData(String title, int num) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
        Text(
          "$num NANO",
          style: TextStyle(
              fontSize: 20,
              color: Color(0xFF6e9bc5),
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
