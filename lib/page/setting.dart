import 'package:bloomskyx_app/common/api/api.dart';
import 'package:bloomskyx_app/common/icon/setting_icon.dart';
import 'package:bloomskyx_app/common/store.dart';
import 'package:bloomskyx_app/page/switch_account.dart';
import 'package:bloomskyx_app/widget/my_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../widget/loading.dart';

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
      onTap: () async {
        try {
          Loading.show("");
          await Api().sendResetPasswordEmail(store.getCurrentAccount()!.email);
          Loading.close();

          MyDialog().show(Get.context!,
              title: "Change Password",
              content: Text(
                "Please check your email to complete password reset ${store.getCurrentAccount()!.email}",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              showCancel: false);
        } catch (e) {
          Loading.close();
        }
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
    ),
    SettingItem(
      title: "Delete Account",
      desc: "Permanently delete your account and data",
      icon: Icon(
        SettingIcon.deleteAccountIcon,
        color: Color(0xFF5bb297),
      ),
      iconBackgroundColor: Color(0xFFe9f9fe),
      onTap: () {
        MyDialog().show(
          Get.context!,
          title: "Are you sure you want to delete account?",
          content: Text(
            "If you delete this account you will nolonger see the data and will lose anypast and future rewards from it. Areyou sure you want to delete this account?",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.red,
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
            try {
              Loading.show("");
              await Api().deleteAccount();
              // 删除本地缓存的账户信息，如果还有账户就切换账户，没有就直接到登录页面了
              store.deleteAccount(store.getCurrentAccount());
              store.removeCurrentAccount();
              var accounts = store.getAccounts();
              //没有其他账户就直接去登录页面，还有账户就切换账户
              print("accounts isEmpty : ${accounts.isEmpty}");
              Loading.close();
              if (accounts.isEmpty) {
                Get.offAllNamed("/login");
                return;
              }
              Api().setAuth(accounts[0].accessToken);
              store.setCurrentAccount(accounts[0]);
              Get.offAllNamed("/");
            } catch (e) {
              Loading.close();
            }
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
        backgroundColor: Color(0xFFc6e9f5),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFFc6e9f5), Colors.white],
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
