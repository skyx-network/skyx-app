import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/leaderboard_response_entity.dart';

class _Rank {
  final String user;
  final String grants;

  _Rank(this.user, this.grants);
}

class RankingTable extends StatelessWidget {
  RankingTable(
      {super.key,
      required this.rankList,
      required this.tabController,
      required this.tabList});

  final List<LeaderboardResponseRank> rankList;
  final TabController tabController;
  final List<String> tabList;

  // final List<_Rank> data = [
  //   _Rank("Xu******422@gmail.com", "19779.00"),
  //   _Rank("Xw******088@protonmail.com", "17704.00"),
  //   _Rank("35******766@gq.com", "17623.00"),
  //   _Rank("tj******[97@gmail.com", "19779.00"),
  //   _Rank("th******y95@gmail.com", "19779.00"),
  //   _Rank("Xu******422@gmail.com", "19779.00"),
  //   _Rank("Xw******088@protonmail.com", "17704.00"),
  //   _Rank("35******766@gq.com", "17623.00"),
  //   _Rank("tj******[97@gmail.com", "19779.00"),
  //   _Rank("th******y95@gmail.com", "19779.00")
  // ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rank",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              Text(
                "Grants Distributed",
                style: TextStyle(fontSize: 12, color: Color(0xFFacaeab)),
              )
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: tabList
                .map(
                  (label) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: _buildRowRank(),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildRowRank() {
    var index = 1;
    return rankList
        .map(
          (d) => Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${d.index}",
                  style: TextStyle(
                      color: Color(0xFF528573),
                      fontWeight: FontWeight.w600,
                      fontSize: 13),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    d.email,
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(text: "${d.amount}"),
                      const TextSpan(text: " NANO")
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}
