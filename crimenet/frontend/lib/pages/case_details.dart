import 'package:flutter/material.dart';

class CaseDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Case Details', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Case Title',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFC55A),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Description of the case goes here.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF2C4E80),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Evidence: [Uploaded files/images]',
                style: TextStyle(color: Color(0xFFFFC55A)),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.info, color: Color(0xFFFC4100)),
                SizedBox(width: 8),
                Text(
                  'Status: Open',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFF2C4E80),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView(
                  children: [
                    Text(
                      'Comments/discussions section',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFC4100),
                ),
                onPressed: () {},
                child: Text(
                  'Contribute Clues or Suggestions',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
