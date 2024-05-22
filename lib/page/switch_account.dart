import 'package:bloomskyx_app/common/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/api/api.dart';
import '../models/store_account_entity.dart';

class SwitchAccountPage extends StatefulWidget {
  const SwitchAccountPage({super.key});

  @override
  State<SwitchAccountPage> createState() => _SwitchAccountPageState();
}

class _SwitchAccountPageState extends State<SwitchAccountPage> {
  List<StoreAccountEntity> accounts = [];
  late StoreAccountEntity currentAccount;

  @override
  void initState() {
    super.initState();

    accounts = store.getAccounts();
    currentAccount = store.getCurrentAccount()!;
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
          "Switch Account",
          style: TextStyle(fontSize: 22),
        ),
        backgroundColor: Color(0xFFf5fffb),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFFf5fffb),
            Colors.white,
            Colors.white,
            Colors.white
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                reverse: false,
                children: accounts.map((e) => _buildAccountItem(e)).toList(),
              ),
            ),
            Container(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed("/login");
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF37ad8b)),
                ),
                child: Text(
                  "Add Account",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAccountItem(StoreAccountEntity account) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(
            color: currentAccount.id == account.id
                ? Color(0xFF78b099)
                : Color(0xFFe1e5e4),
            width: 2),
        borderRadius: BorderRadius.circular(25),
        color:
            currentAccount.id == account.id ? Color(0xFFeaf5f3) : Colors.white,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(20),
        leading: CircleAvatar(
          backgroundImage: AssetImage(
            "assets/images/avatar/avatar_1.webp",
          ),
          minRadius: 30,
          maxRadius: 30,
        ),
        title: Text(
          account.email,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: () {
          setState(() {
            currentAccount = account;
          });
          //设置APi请求的auth头为当前要切换的用户的token
          Api().setAuth(account.accessToken);
          store.setCurrentAccount(account);
          Get.offAllNamed("/");
        },
      ),
    );
  }
}
