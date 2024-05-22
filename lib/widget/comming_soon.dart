import 'package:flutter/material.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xFF585e76),
          Color(0xFF585e76),
          Color(0xFF585e76).withOpacity(0.8),
          Color(0xFF585e76).withOpacity(0.1),
          // Colors.white
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Coming",
            style: TextStyle(
                color: Colors.white, fontSize: 46, fontWeight: FontWeight.w700),
          ),
          Text(
            "soon...",
            style: TextStyle(
                color: Colors.white, fontSize: 38, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.all(12),
            color: Color(0xFF213de1),
            child: Text(
              "Our Community",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Text("Monetize Your Own Weather",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700))
        ],
      ),
    );
  }
}
