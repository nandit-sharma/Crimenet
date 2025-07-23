import 'package:flutter/material.dart';

class AdminPanelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Color(0xFF2C4E80),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'Admin moderation features go here.',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
