import 'package:flutter/material.dart';
import '../widgets/shared_layout.dart';
import '../widgets/modern_button.dart';

class AiDetectivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SharedLayout(
      currentIndex: 3,
      title: 'AI Detective',
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF101A30), Color(0xFF1E3050)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Crime Prediction',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFC55A),
                  ),
                ),
                SizedBox(height: 24),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter clues',
                    prefixIcon: Icon(Icons.search, color: Color(0xFFFC4100)),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 32),
                ModernButton(
                  text: 'Get Prediction',
                  icon: Icons.psychology,
                  onPressed: () {},
                ),
                SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF2C4E80), Color(0xFF101A30)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Prediction result will appear here.',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
