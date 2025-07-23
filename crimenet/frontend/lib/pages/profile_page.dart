import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Text('Profile Page', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
