import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFF2C4E80),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Privacy policy content goes here.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
