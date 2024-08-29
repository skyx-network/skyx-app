import 'dart:async';

import 'package:bloomskyx_app/common/api/api.dart';
import 'package:bloomskyx_app/widget/default_text_form_field.dart';
import 'package:bloomskyx_app/widget/default_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/appColors.dart';
import '../widget/loading.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var titleTextStyle = TextStyle(color: Colors.white, fontSize: 28);
  var linkTextStyle = const TextStyle(color: AppColors.textButtonColor);

  final _formKey = GlobalKey<FormState>();
  bool checkBoxValue = false;
  bool isSendCodeValidate = false; //如果是code校验的话就只会校验email正不正确

  Timer? _timer;
  int _start = 60; // 假设倒计时为60秒
  String _buttonText = 'Send Code';

  final _passwordController = TextEditingController();

  String email = "";
  String code = "";

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.focusScope?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back(closeOverlays: true, canPop: false);
            },
          ),
          backgroundColor: AppColors.loginTopColor[0],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(100),
                  ),
                  gradient: LinearGradient(
                    colors: AppColors.loginTopColor,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      offset: Offset(0, 3),
                      spreadRadius: 6,
                      blurRadius: 20,
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30, bottom: 30, right: 60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create Account",
                            style: titleTextStyle,
                          ),
                          Text(
                            "sign up with your email and your account will be create shortly.",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DefaultTextFormField(
                        label: "Email",
                        hintText: "Please enter email address",
                        textInputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "Please enter a valid email address";
                          }
                          // 正则表达式校验邮箱
                          String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,5}$';
                          RegExp regex = RegExp(pattern);
                          if (!regex.hasMatch(value!)) {
                            return 'Please enter a valid email address2';
                          }
                          return null;
                        },
                        onSaved: (newEmail) => email = newEmail!,
                      ),
                      DefaultTextFormField(
                        label: "Verify Code",
                        hintText: "Email verify code",
                        textInputType: TextInputType.number,
                        onSaved: (newCode) => code = newCode!,
                        suffixWidget: IconButton(
                          onPressed: _start == 60 ? sendCode : null,
                          disabledColor: Colors.grey,
                          icon: Text(
                            _buttonText,
                            style: TextStyle(
                              color: AppColors.textButtonColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (isSendCodeValidate) {
                            return null;
                          }
                          if (value != null && value.isEmpty) {
                            return "Please enter 6 digits";
                          }

                          if (value!.length != 6) {
                            return "Please enter 6 digits";
                          }

                          return null;
                        },
                      ),
                      DefaultTextFormField(
                        label: "Password",
                        obscureText: true,
                        hintText: "Enter your password",
                        textInputType: TextInputType.text,
                        controller: _passwordController,
                        validator: (value) {
                          if (isSendCodeValidate) {
                            return null;
                          }
                          if (value != null && value.isEmpty) {
                            return "at least 8 characters，1 number，at least one uppercase letter";
                          }
                          // 验证密码是否至少8位
                          if (value!.length < 8) {
                            return 'at least 8 characters，1 number，at least one uppercase letter';
                          }

                          // 验证密码中是否至少有一个数字
                          RegExp hasNumber = RegExp(r'\d');
                          if (!hasNumber.hasMatch(value)) {
                            return 'at least 8 characters，1 number，at least one uppercase letter';
                          }

                          // 验证密码中是否至少有一个大写字母
                          RegExp hasUpper = RegExp(r'[A-Z]');
                          if (!hasUpper.hasMatch(value)) {
                            return 'at least 8 characters，1 number，at least one uppercase letter';
                          }

                          return null;
                        },
                      ),
                      DefaultTextFormField(
                        label: "Confirm Password",
                        obscureText: true,
                        hintText: "Confirm your password",
                        textInputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (isSendCodeValidate) {
                            return null;
                          }
                          if (value != null && value.isEmpty) {
                            return "Password format is incorrect";
                          }

                          if (_passwordController.text != value) {
                            return "Password format is incorrect";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: checkBoxValue,
                              onChanged: (value) => {
                                    setState(() {
                                      checkBoxValue = value!;
                                    })
                                  }),
                          Expanded(
                            child: Wrap(
                              children: [
                                Text("I've read and agreed to Skyx's "),
                                GestureDetector(
                                  onTap: () async {
                                    await launchUrl(
                                      Uri.parse(
                                          "https://skyxglobal.com/#/user-agreement"),
                                    );
                                  },
                                  child: Text(
                                    "User Agreement",
                                    style: linkTextStyle,
                                  ),
                                ),
                                Text(" and "),
                                GestureDetector(
                                  onTap: () async {
                                    await launchUrl(
                                      Uri.parse(
                                          "https://skyxglobal.com/#/privacy-policy"),
                                    );
                                  },
                                  child: Text(
                                    "Privacy Policy",
                                    style: linkTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () async {
                            isSendCodeValidate = false;
                            if (!_formKey.currentState!.validate()) {
                              print("form内容不对");
                              return;
                            }

                            _formKey.currentState!.save();
                            if (!checkBoxValue) {
                              DefaultToast.show(
                                "Please check the box to agree to the agreement",
                                type: DefaultToastType.Error,
                              );
                              return;
                            }
                            Loading.show("Creating Account");
                            try {
                              await Api().register(
                                  code, email, _passwordController.text);
                            } catch (e) {
                              DefaultToast.show(
                                "Failed to create account",
                                type: DefaultToastType.Error,
                              );
                            }
                            Loading.close();
                            // Get.back();
                            Get.offAllNamed("/login");
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFF015678)),
                          ),
                          child: const Text(
                            "Sign up",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        // ),
      ),
    );
  }

  void sendCode() async {
    isSendCodeValidate = true;
    if (!_formKey.currentState!.validate()) {
      return;
    }
    // 调用Form的保存方法
    _formKey.currentState!.save();
    if (email == "") {
      return;
    }

    if (_start == 60) {
      try {
        Loading.show("Loading");
        await Api().sendVerifyCode(email);
        _startTimer();
        Loading.close();
      } catch (e) {
        print(e);
        Loading.close();
      }
    }
  }

  void _startTimer() {
    _buttonText = 'Resend after ${_start}s'; // 初始化按钮文本为倒计时时间
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
          _buttonText = 'Resend after ${_start}s';
        });
      } else {
        setState(() {
          _timer?.cancel();
          _buttonText = 'Send Code';
          _start = 60; // 重置倒计时时间，准备下一次倒计时
        });
      }
    });
  }
}
