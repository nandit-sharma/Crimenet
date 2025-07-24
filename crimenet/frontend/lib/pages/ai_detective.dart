import 'package:flutter/material.dart';

class AiDetectivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/home');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
          ),
          title: Text('AI Detective', style: TextStyle(color: Colors.white)),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AI Crime Prediction',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFC55A),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter clues',
                  prefixIcon: Icon(Icons.search, color: Color(0xFFFC4100)),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFC4100),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Get Prediction',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF2C4E80),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Prediction result will appear here.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
