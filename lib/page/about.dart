import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
          "About the grant card",
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            _buildAboutItem(
              "What is NANO?",
              child: Text(
                "NANO is the weather data point system within the BloomskyX ecosystem. These points can be exchanged for BLX, BloomskyX’s native token.",
              ),
            ),
            _buildAboutItem(
              "Understanding the NANO Amount on Your Grant Card",
              child: Text(
                "The NANO value indicated on your grant card represents the total NANO points you are eligible to accumulate throughout the duration of the activity period.",
              ),
            ),
            _buildAboutItem(
              "Guidelines for Accumulating NANO",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildUl(
                    Icons.fiber_manual_record,
                    "Each user can collect NANO from one NANO card up to two times per day",
                  ),

                  _buildUl(
                    Icons.fiber_manual_record,
                    "A minimum interval of six hours is required between each collection",
                  ),

                  _buildUl(
                    Icons.fiber_manual_record,
                    "The daily limit for NANO collection is calculated as:",
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: _buildUl(
                      Icons.fiber_manual_record_outlined,
                      "Newcomer Exclusive Reward: Total NANO available on all grant cards / the number of days in the activity period",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: _buildUl(
                      Icons.fiber_manual_record_outlined,
                      "NFT Activation Reward: Daily Total NANO distribution amount / Number of NFTs within the Lock-up Address.",
                    ),
                  )
                ],
              ),
            ),

            _buildAboutItem(
              "How Can You Obtain a Grant Card?",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildUl(
                    Icons.fiber_manual_record,
                    "By registering as a new user on the BloomskyX platform",
                  ),
                  _buildUl(
                    Icons.fiber_manual_record,
                    "Through the activation of a BloomSkyX NFT",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutItem(String title, {required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          child
        ],
      ),
    );
  }

  Widget _buildUl(IconData icon, String text) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black),
        children: [
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Icon(
                icon,
                size: 10,
              ),
            ),
            alignment: PlaceholderAlignment.middle,
          ),
          TextSpan(
            text: text,
          ),
        ],
      ),
    );
  }
}
