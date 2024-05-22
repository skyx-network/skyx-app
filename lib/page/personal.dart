import 'package:bloomskyx_app/common/api/api.dart';
import 'package:bloomskyx_app/models/profile_response_entity.dart';
import 'package:bloomskyx_app/widget/persional_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../widget/custom_future_builder.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  late Future<ProfileResponseEntity> _future;

  Future<ProfileResponseEntity> fetchData() async {
    return await Api().getAccountProfile();
  }

  @override
  void initState() {
    super.initState();
    _future = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder<ProfileResponseEntity>(
        future: _future,
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
                      colors: [Color(0XFF50b08f), Color(0XFF85cebf)],
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
