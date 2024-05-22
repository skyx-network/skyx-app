import 'package:bloomskyx_app/common/icon/setting_icon.dart';
import 'package:bloomskyx_app/common/store.dart';
import 'package:bloomskyx_app/page/switch_account.dart';
import 'package:bloomskyx_app/widget/my_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  SettingGroup settings = SettingGroup("Account", [
    SettingItem(
      title: "Switch Account",
      desc: "You can add and switch between multiple accounts",
      icon: Icon(
        SettingIcon.switchAccountIcon,
        color: Color(0xFF5bb297),
      ),
      iconBackgroundColor: Color(0xFFecf7f5),
      onTap: () {
        Get.to(() => SwitchAccountPage());
      },
    ),
    SettingItem(
      title: "Change Password",
      desc: "Request a password reset email to change your password",
      icon: Icon(
        SettingIcon.changePasswordIcon,
        color: Color(0xFFe3b845),
      ),
      iconBackgroundColor: Color(0xFFfcf8e7),
      onTap: () {
        print("123");
      },
    ),
    SettingItem(
      title: "Logout",
      desc: "Logout of your account",
      icon: Icon(
        SettingIcon.logoutIcon,
        color: Color(0xFF58bef2),
      ),
      iconBackgroundColor: Color(0xFFe9f9fe),
      onTap: () {
        MyDialog().show(
          Get.context!,
          content: Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Are you sure to log out? ${store.getCurrentAccount()?.email}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          okWidget: Text(
            "Confirm",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.redAccent,
            ),
          ),
          ok: () async {
            await store.removeCurrentAccount();
            print("退出登录跳转login");
            Get.offAllNamed("/login");
          },
        );
      },
    )
  ]);

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
          "Setting",
          style: TextStyle(fontSize: 22),
        ),
        backgroundColor: Color(0xFFf5fffb),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFFf5fffb), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Column(
          children: [_buildSettingGroup(settings.groupName, settings.items)],
        ),
      ),
    );
  }

  Widget _buildSettingGroup(String groupName, List<SettingItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          groupName,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        SizedBox(
          height: 15,
        ),
        Column(
          children: items
              .map(
                (e) => GestureDetector(
                  onTap: e.onTap,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.only(
                        left: 15, top: 15, bottom: 15, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          offset: Offset(0, 5),
                          spreadRadius: 2,
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                              color: e.iconBackgroundColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: e.icon,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                                Text(
                                  e.desc ?? "",
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}

class SettingGroup {
  final String groupName;
  final List<SettingItem> items;

  SettingGroup(this.groupName, this.items);
}

class SettingItem {
  final String title;
  final String? desc;
  final Widget icon;
  final Color iconBackgroundColor;
  final void Function()? onTap;

  SettingItem(
      {required this.title,
      this.desc,
      required this.icon,
      required this.iconBackgroundColor,
      this.onTap});
}
