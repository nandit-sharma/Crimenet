import '../widgets/modern_button.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _index = 0;
  final List<Map<String, String>> _slides = [
    {'title': 'Welcome', 'desc': 'Discover how the app helps solve crimes.'},
    {
      'title': 'AI Detective',
      'desc': 'AI assists in solving cases efficiently.',
    },
    {'title': 'Community', 'desc': 'Contribute and keep your community safe.'},
  ];
  void _next() {
    if (_index < 2)
      setState(() => _index++);
    else
      Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101A30),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF101A30), Color(0xFF1E3050)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFFFC4100), Color(0xFFFFC55A)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFFC4100).withOpacity(0.3),
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Icon(Icons.lightbulb, color: Colors.white, size: 48),
                ),
                SizedBox(height: 32),
                Text(
                  _slides[_index]['title']!,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFC55A),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  _slides[_index]['desc']!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Color(0xFF2C4E80)),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/login'),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Color(0xFFFC4100),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ModernButton(
                      text: _index == 2 ? 'Get Started' : 'Next',
                      icon: _index == 2 ? Icons.check : Icons.arrow_forward,
                      width: 120,
                      onPressed: _next,
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (i) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: _index == i ? 16 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _index == i
                            ? Color(0xFFFC4100)
                            : Color(0xFFFFC55A),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
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
