import 'package:flutter/material.dart';

class EmergencyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFFFC4100),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.warning, color: Color(0xFFFC4100), size: 80),
              SizedBox(height: 32),
              Text(
                'If you are in danger or need urgent help, use the button below to call emergency services.',
                style: TextStyle(
                  color: Color(0xFF2C4E80),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.call, color: Colors.white, size: 32),
                  label: Text(
                    'Call Emergency',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFC4100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    // TODO: Implement emergency call logic
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
