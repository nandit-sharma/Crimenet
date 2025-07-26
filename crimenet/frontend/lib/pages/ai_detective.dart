import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/modern_button.dart';

class AiDetectivePage extends StatefulWidget {
  @override
  _AiDetectivePageState createState() => _AiDetectivePageState();
}

class _AiDetectivePageState extends State<AiDetectivePage> with SingleTickerProviderStateMixin {
  final _cluesController = TextEditingController();
  bool _isLoading = false;
  String _prediction = '';
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _cluesController.dispose();
    super.dispose();
  }

  void _getPrediction() async {
    setState(() => _isLoading = true);
    await Future.delayed(Duration(seconds: 2)); // Simulate AI processing
    setState(() {
      _isLoading = false;
      _prediction = '''
**AI Analysis**:
- **Clue Analysis**: Based on the provided clues, the incident likely involves [mock analysis].
- **Next Steps**:
  1. Investigate nearby CCTV footage.
  2. Interview potential witnesses in the area.
  3. Cross-reference with similar cases in the database.
''';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Detective', style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0A1C3A), Color(0xFF1E3050)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'AI Crime Prediction',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFD180),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: TextField(
                    controller: _cluesController,
                    decoration: InputDecoration(
                      labelText: 'Enter clues',
                      prefixIcon: Icon(Icons.search, color: Color(0xFFFF3D00)),
                      labelStyle: GoogleFonts.roboto(color: Color(0xFFFFD180)),
                    ),
                    style: GoogleFonts.roboto(color: Colors.white),
                    maxLines: 3,
                  ),
                ),
                SizedBox(height: 32),
                ModernButton(
                  text: 'Get Prediction',
                  icon: Icons.psychology,
                  onPressed: _getPrediction,
                ),
                SizedBox(height: 16),
                ModernButton(
                  text: 'View History',
                  icon: Icons.history,
                  onPressed: () => Navigator.pushNamed(context, '/ai_history'),
                ),
                SizedBox(height: 32),
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF1E3050), Color(0xFF0A1C3A)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: _isLoading
                          ? Center(child: CircularProgressIndicator(color: Color(0xFFFF3D00)))
                          : Text(
                              _prediction.isEmpty ? 'Prediction result will appear here.' : _prediction,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF1E3050),
        selectedItemColor: Color(0xFFFF3D00),
        unselectedItemColor: Colors.white.withOpacity(0.7),
        currentIndex: 3,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/recent_cases');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/community');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/ai_detective');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Recent Cases'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.psychology), label: 'AI'),
        ],
      ),
    );
  }
}