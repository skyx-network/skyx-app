import 'package:bloomskyx_app/common/api/api.dart';
import 'package:bloomskyx_app/models/profile_response_entity.dart';
import 'package:bloomskyx_app/widget/persional_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../widget/custom_future_builder.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({super.key});

  Future<ProfileResponseEntity> fetchData() async {
    return await Api().getAccountProfile();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<ProfileResponseEntity>(
        future: fetchData,
        builder: (context, snapshot) {
          var data = snapshot.data;
          return Container(
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0XFF3271ae), Color(0XFF106898)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Positioned(
                    top: 130,
                    left: 0,
                    right: 0,
                    child: PersionalCard(
                      data: data,
                    )),
                Positioned(
                  top: 50,
                  right: 15,
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed("/setting");
                    },
                    icon: Icon(
                      Icons.settings,
                      size: 26,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
