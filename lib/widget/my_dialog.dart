import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialog {
  void show(BuildContext context,
      {String? title,
      Widget? content,
      Function? cancel,
      Function? ok,
      Text? okWidget,
      Text? cancelWidget,
      bool? showCancel = true,
      bool? showOk = true}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            surfaceTintColor: Colors.white,
            content: SingleChildScrollView(
              child: Container(
                // height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          if (title != null)
                            Text(
                              title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (content != null)
                            DefaultTextStyle(
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
                              ),
                              child: content,
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        if (showCancel != null && showCancel)
                          Expanded(
                            child: DialogButton(
                              text: cancelWidget ?? Text("Cancel"),
                              onTap: () {
                                Navigator.of(context).pop(); // 关闭对话框

                                if (cancel != null) {
                                  cancel();
                                }
                              },
                            ),
                          ),
                        if (showOk == true && showCancel == true)
                          Container(
                            width: 1,
                            height: 48,
                            color: const Color.fromARGB(255, 220, 220, 220),
                          ),
                        if (showOk != null && showOk)
                          Expanded(
                            child: DialogButton(
                              text: okWidget ?? Text("Confirm"),
                              position: "right",
                              onTap: () {
                                if (ok != null) {
                                  ok();
                                }
                                if(Navigator.of(context).canPop()){
                                  Navigator.of(context).maybePop(); // 关闭对话框
                                }
                              },
                            ),
                          )
                      ],
                    )
                  ],
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: EdgeInsets.all(0),
          );
        });
  }
}

class DialogButton extends StatelessWidget {
  final Text text;
  final Function? onTap;
  final String position;

  const DialogButton(
      {super.key, required this.text, this.onTap, this.position = "left"});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        // color: Colors.black,
        borderRadius: BorderRadius.only(
          bottomLeft: position == 'left' ? Radius.circular(20) : Radius.zero,
          topRight: Radius.zero,
          topLeft: Radius.zero,
          bottomRight: position == 'right' ? Radius.circular(20) : Radius.zero,
        ),
        border: Border(
          top: const BorderSide(
              color: Color.fromARGB(255, 220, 220, 220), width: 1.0),
          // right: position == 'left'
          //     ? const BorderSide(
          //         color: Color.fromARGB(255, 220, 220, 220), width: 1.0)
          //     : BorderSide.none,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (onTap != null) {
              onTap!();
            }
          },
          child: Center(
            child: text,
          ),
        ),
      ),
    );
  }
}
