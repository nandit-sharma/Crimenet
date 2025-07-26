import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import '../widgets/shared_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String searchQuery = '';
  Map<String, List<String>> stateCityMap = {};
  List<String> stateOptions = [];
  List<String> cityOptions = [];
  bool isLoading = true;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
    loadStateCityData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> loadStateCityData() async {
    final String response = await rootBundle.loadString('assets/Data.json');
    final data = json.decode(response) as Map<String, dynamic>;
    setState(() {
      stateCityMap = data.map((k, v) => MapEntry(k, List<String>.from(v)));
      stateOptions = stateCityMap.keys.toList();
      cityOptions = stateOptions.isNotEmpty
          ? stateCityMap[stateOptions[0]] ?? []
          : [];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SharedLayout(
      currentIndex: 0,
      title: 'C R I M E N E T',
      child: isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xFFFC4100)))
          : SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF101A30), Color(0xFF1E3050)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Container(
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
                          child: TextField(
                            onChanged: (value) =>
                                setState(() => searchQuery = value),
                            style: GoogleFonts.roboto(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Search for crimes...',
                              hintStyle: GoogleFonts.roboto(
                                color: Color(0xFFFFC55A).withOpacity(0.7),
                              ),
                              border: InputBorder.none,
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Color(0xFFFC4100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Expanded(
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: _mainButton(
                                      context,
                                      'Report Crime',
                                      '/report',
                                      Icons.report,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: _mainButton(
                                      context,
                                      'Emergency',
                                      '/emergency',
                                      Icons.warning,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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

  Widget _mainButton(
    BuildContext context,
    String label,
    String route,
    IconData icon,
  ) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;
        bool isPressed = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: GestureDetector(
            onTapDown: (_) {
              setState(() => isPressed = true);
              _controller.reverse();
              Future.delayed(
                Duration(milliseconds: 100),
                () => _controller.forward(),
              );
            },
            onTapUp: (_) => setState(() => isPressed = false),
            onTapCancel: () => setState(() => isPressed = false),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
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
                    blurRadius: isHovered ? 15 : 10,
                    offset: Offset(0, isHovered ? 6 : 4),
                    spreadRadius: isHovered ? 1 : 0,
                  ),
                  if (isHovered)
                    BoxShadow(
                      color: Color(0xFFFC4100).withOpacity(0.2),
                      blurRadius: 20,
                      offset: Offset(0, 8),
                    ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  splashColor: Color(0xFFFFC55A).withOpacity(0.3),
                  highlightColor: Color(0xFFFC4100).withOpacity(0.2),
                  onTap: () => Navigator.pushNamed(context, route),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          transform: isHovered
                              ? Matrix4.translationValues(0, -3, 0)
                              : Matrix4.translationValues(0, 0, 0),
                          child: Icon(icon, size: 44, color: Color(0xFFFC4100)),
                        ),
                        const SizedBox(height: 16),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          transform: isHovered
                              ? Matrix4.translationValues(0, -2, 0)
                              : Matrix4.translationValues(0, 0, 0),
                          child: Text(
                            label,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
