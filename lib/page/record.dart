import 'package:bloomskyx_app/common/api/api.dart';
import 'package:bloomskyx_app/common/utils.dart';
import 'package:bloomskyx_app/models/profile_response_entity.dart';
import 'package:bloomskyx_app/models/score_response_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/custom_future_builder.dart';

class RecordPage extends StatefulWidget {
  RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  final List<String> columns = ["For What", "Harverst NANO", "Time"];

  Future<List<Object>> fetchData() async {
    // var x = Future.wait([Api().getScores(),Api().getAccountProfile()]);
    return await Future.wait([Api().getScores(), Api().getAccountProfile()]);
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
          "Record",
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: CustomFutureBuilder<List<Object>>(
        future: fetchData,
        builder: (context, snapshot) {
          ProfileResponseEntity profile =
              snapshot.data?[1] as ProfileResponseEntity;
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        text: "You have harvested a total of ",
                        children: [
                          TextSpan(
                              text: "${profile.totalEarning.score}",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF015678))),
                          TextSpan(text: " NANO")
                        ],
                      ),
                    ),
                  ),
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      buildTableTitle(),
                      ...buildDataCell(
                          snapshot.data?[0] as ScoreResponseEntity?)
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  TableRow buildTableTitle() {
    return TableRow(
        children: columns
            .map(
              (title) => Padding(
                padding: EdgeInsets.only(top: 30, bottom: 15),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                ),
              ),
            )
            .toList());
  }

  List<TableRow> buildDataCell(ScoreResponseEntity? data) {
    if (data == null) {
      return [];
    }

    return data.content
        .map(
          (bean) => TableRow(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(bean.forWhat,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16)),
              ),
              Text(
                "+${bean.amount}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF4994c4),
                    fontWeight: FontWeight.w700),
              ),
              Text(
                Utils.formatDateTimeString(bean.createdAt),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
        )
        .toList();
  }
}
