import 'package:flutter/material.dart';

class RecentCasesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recent Cases Solved',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.check_circle, color: Color(0xFFFC4100)),
              title: Text(
                'Case 1',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Solved',
                style: TextStyle(color: Color(0xFFFFC55A)),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.check_circle, color: Color(0xFFFC4100)),
              title: Text(
                'Case 2',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Solved',
                style: TextStyle(color: Color(0xFFFFC55A)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
