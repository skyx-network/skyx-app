import 'package:bloomskyx_app/common/api/api.dart';
import 'package:bloomskyx_app/common/store.dart';
import 'package:bloomskyx_app/models/login_response_entity.dart';
import 'package:bloomskyx_app/widget/default_text_field.dart';
import 'package:bloomskyx_app/widget/default_text_form_field.dart';
import 'package:bloomskyx_app/widget/default_toast.dart';
import 'package:bloomskyx_app/widget/loading.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var titleTextStyle = TextStyle(color: Colors.white, fontSize: 28);
    return GestureDetector(
      onTap: () {
        Get.focusScope?.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(100),
                  ),
                  gradient: LinearGradient(
                    colors: [Color(0xFF56c8af), Color(0xFF58bb9f)],
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
                child: Padding(
                  padding: EdgeInsets.only(left: 30, bottom: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: titleTextStyle,
                      ),
                      Text(
                        "Back!",
                        style: titleTextStyle,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    DefaultTextField(
                      label: "Email",
                      hintText: "Please enter email address",
                      controller: _emailController,
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DefaultTextField(
                      label: "Password",
                      hintText: "Please enter password",
                      controller: _passwordController,
                      obscureText: true,
                      textInputType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        print(_emailController.text);
                        print("forgot");
                      },
                      child: Text(
                        "Forgot your password?",
                        style:
                            TextStyle(color: Color(0xFF6cc1a2), fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_emailController.text.isEmpty) {
                            DefaultToast.show(
                              "Please enter a valid email format for username",
                              type: DefaultToastType.Error,
                            );
                            return;
                          }
                          if (_passwordController.text.isEmpty) {
                            DefaultToast.show(
                              "Please enter password",
                              type: DefaultToastType.Error,
                            );
                            return;
                          }

                          Loading.show("logging in");
                          try {
                            LoginResponseEntity loginResponse = await Api()
                                .login(_emailController.text,
                                    _passwordController.text);
                            await store.addAccount(loginResponse);
                            Api().setAuth(loginResponse.accessToken);
                            Loading.close();
                            Get.toNamed("/");
                          } catch (e) {
                            if (e is DioException) {
                              if (e.response?.statusCode == 401) {
                                DefaultToast.show(
                                  "Incorrect account or password",
                                  type: DefaultToastType.Error,
                                );
                              } else {
                                DefaultToast.show(
                                  "Login Failed",
                                  type: DefaultToastType.Error,
                                );
                              }
                            }
                            Loading.close();
                            print(e);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFF37ad8b)),
                        ),
                        child: Text(
                          "Sign in",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed("/register");
                      },
                      child: Text(
                        "Create an account",
                        style:
                            TextStyle(color: Color(0xFF6cc1a2), fontSize: 16),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
