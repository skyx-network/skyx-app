import 'dart:ffi';

import 'package:bloomskyx_app/common/api/api.dart';
import 'package:bloomskyx_app/models/leaderboard_response_entity.dart';
import 'package:bloomskyx_app/widget/custom_future_builder.dart';
import 'package:bloomskyx_app/widget/ranking_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Leaderboard extends StatefulWidget {
  Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard>
    with SingleTickerProviderStateMixin {
  final List<String> tabList = ["All-time", "7 days", "30 days"];

  int getTimestampOfEndOfDay(int daysAgo) {
    DateTime now = DateTime.now();
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    DateTime targetDay = endOfDay.subtract(Duration(days: daysAgo));
    return targetDay.millisecondsSinceEpoch ~/ 1000;
  }

  Future<Map<String, LeaderboardResponseEntity>> fetchData() async {
    int now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    var allInfo = await Api().getLeaderboardInfo();
    var weekInfo = await Api()
        .getLeaderboardInfo(from: getTimestampOfEndOfDay(7), to: now);
    var monthInfo = await Api()
        .getLeaderboardInfo(from: getTimestampOfEndOfDay(30), to: now);
    return {"All-time": allInfo, "7 days": weekInfo, "30 days": monthInfo};
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Leaderboard",
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: CustomFutureBuilder<Map<String, LeaderboardResponseEntity>>(
        future: fetchData,
        builder: (context, snapshot) {
          LeaderboardResponseEntity? leaderboardInfo =
              snapshot.data?[tabList[0]];
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _StatisticalData(
                          value: '${leaderboardInfo?.me.index}',
                          unit: "Rank",
                          icon: Icon(Icons.ac_unit),
                          backgroundColor: Color(0xFFe8f5f2),
                          describe: "My Ranking"),
                      Container(
                        width: 20,
                        height: 38,
                        child: VerticalDivider(
                          color: Color(0xFFeff1ee),
                          thickness: 2.0,
                        ),
                      ),
                      _StatisticalData(
                        value: '${leaderboardInfo?.me.amount}',
                        unit: "NANO",
                        icon: Icon(Icons.ac_unit),
                        backgroundColor: Color(0xFFfbf5e4),
                        describe: "My Grants",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Color(0xFFf7f7f5),
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(color: Color(0xFFdddfdc), width: 2)),
                  child: TabBar(
                      padding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.zero,
                      controller: _tabController,
                      unselectedLabelColor: Color(0xFF6b6b6b),
                      labelColor: Colors.black,
                      tabs: tabList
                          .map(
                            (label) => Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 25),
                              child: Text(
                                label,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                          .toList(),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Color(0xFFd9ece7),
                      ),
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      dividerHeight: 0),
                ),
                Expanded(
                  child: RankingTable(
                    tabController: _tabController,
                    tabList: tabList,
                    rankData: snapshot.data,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatisticalData extends StatelessWidget {
  const _StatisticalData(
      {super.key,
      required this.value,
      required this.unit,
      required this.icon,
      required this.backgroundColor,
      required this.describe});

  final String value;
  final String unit;
  final Icon icon;
  final Color backgroundColor;
  final String describe;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 41,
        height: 41,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
        ),
        child: icon,
      ),
      SizedBox(
        width: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
              children: [
                TextSpan(text: value),
                const TextSpan(text: " "),
                TextSpan(text: unit)
              ],
            ),
          ),
          Text(
            describe,
            style: TextStyle(color: Color(0xFFaeb0ad)),
          )
        ],
      )
    ]);
  }
}
