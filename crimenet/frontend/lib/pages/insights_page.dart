import 'package:flutter/material.dart';

class InsightsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Insights & Analytics',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(
            'Crime Heatmaps',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFC55A),
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Color(0xFF2C4E80),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(Icons.map, color: Color(0xFFFC4100), size: 48),
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Common Patterns',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFC55A),
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Color(0xFF2C4E80),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(Icons.timeline, color: Color(0xFFFC4100), size: 40),
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Most Reported Areas/Types',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFC55A),
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Color(0xFF2C4E80),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                Icons.location_on,
                color: Color(0xFFFC4100),
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
