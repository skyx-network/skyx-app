import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oktoast/oktoast.dart';

enum DefaultToastType { Right, Error }

class DefaultToast {
  static void show(String text,
      {DefaultToastType? type,
      Duration? duration = const Duration(seconds: 5)}) {
    IconData? icon;
    Color? iconColor;

    if (type == DefaultToastType.Right) {
      icon = Icons.check;
      iconColor = Colors.green;
    } else if (type == DefaultToastType.Error) {
      icon = Icons.close;
      iconColor = Colors.red;
    }

    showToastWidget(
      duration: duration,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 10), // 阴影偏移量，向下偏移3个像素
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: iconColor,
                  ),
                  SizedBox(width: 10),
                ],
                Flexible(
                  child: Text(
                    textAlign: TextAlign.center,
                    text,
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                    softWrap: true,
                    style: TextStyle(fontSize: 13),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      position: ToastPosition(align: Alignment.bottomCenter, offset: -110),
    );
  }
}
