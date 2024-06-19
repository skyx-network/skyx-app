import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loading {
  static void show(String? label) {
    Get.dialog(
      barrierDismissible: false,
      Center(
        child: Material(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            height: 130,
            width: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Color(0xFF56c8af),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  label ?? "",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void close() {
    Get.back(closeOverlays: false);
  }
}
