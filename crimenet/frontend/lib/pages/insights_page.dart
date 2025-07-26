import '../widgets/modern_button.dart';
import 'package:flutter/material.dart';

class InsightsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Insights & Analytics',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF101A30), Color(0xFF1E3050)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.all(24),
            children: [
              Text(
                'Crime Heatmaps',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFC55A),
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2C4E80), Color(0xFF101A30)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Icon(Icons.map, color: Color(0xFFFC4100), size: 48),
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Common Patterns',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFC55A),
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2C4E80), Color(0xFF101A30)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Icon(
                    Icons.timeline,
                    color: Color(0xFFFC4100),
                    size: 40,
                  ),
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Most Reported Areas/Types',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFC55A),
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2C4E80), Color(0xFF101A30)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Icon(
                    Icons.location_on,
                    color: Color(0xFFFC4100),
                    size: 40,
                  ),
                ),
              ),
              SizedBox(height: 32),
              ModernButton(
                text: 'Generate Report',
                icon: Icons.analytics,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
