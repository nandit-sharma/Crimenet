import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import '../widgets/modern_button.dart';

class CommunityPage extends StatefulWidget {
  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage>
    with SingleTickerProviderStateMixin {
  String? selectedState;
  String? selectedCity;
  String? selectedStatus = 'All';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  Map<String, List<String>> stateCityMap = {};
  List<String> stateOptions = [];
  List<String> cityOptions = [];
  final List<String> statusOptions = ['All', 'Active', 'Solved'];
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
      selectedState = null;
      selectedCity = null;
    });
  }

  void updateCities(String? selectedState) {
    setState(() {
      cityOptions = selectedState != null
          ? stateCityMap[selectedState] ?? []
          : [];
      selectedCity = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Community',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
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
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: DropdownButtonFormField<String>(
                            value: selectedState,
                            isExpanded: true,
                            items: stateOptions
                                .map(
                                  (s) => DropdownMenuItem(
                                    value: s,
                                    child: Text(
                                      s,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) {
                              if (v != null) {
                                setState(() => selectedState = v);
                                updateCities(v);
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'State',
                              prefixIcon: Icon(
                                Icons.map,
                                color: Color(0xFFFF3D00),
                              ),
                              labelStyle: GoogleFonts.roboto(
                                color: Color(0xFFFFD180),
                              ),
                              hintStyle: GoogleFonts.roboto(
                                color: Color(0xFFFFD180).withOpacity(0.7),
                              ),
                              filled: true,
                              fillColor: Color(0xFF1E3050),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFFFF3D00),
                                ),
                              ),
                            ),
                            dropdownColor: Color(0xFF1E3050),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: DropdownButtonFormField<String>(
                            value: selectedCity,
                            isExpanded: true,
                            items: cityOptions
                                .map(
                                  (c) => DropdownMenuItem(
                                    value: c,
                                    child: Text(
                                      c,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) => setState(() => selectedCity = v),
                            decoration: InputDecoration(
                              labelText: 'City',
                              prefixIcon: Icon(
                                Icons.location_city,
                                color: Color(0xFFFF3D00),
                              ),
                              labelStyle: GoogleFonts.roboto(
                                color: Color(0xFFFFD180),
                              ),
                              hintStyle: GoogleFonts.roboto(
                                color: Color(0xFFFFD180).withOpacity(0.7),
                              ),
                              filled: true,
                              fillColor: Color(0xFF1E3050),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFFFF3D00),
                                ),
                              ),
                            ),
                            dropdownColor: Color(0xFF1E3050),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: DropdownButtonFormField<String>(
                            value: selectedStatus,
                            isExpanded: true,
                            items: statusOptions
                                .map(
                                  (s) => DropdownMenuItem(
                                    value: s,
                                    child: Text(
                                      s,
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) =>
                                setState(() => selectedStatus = v),
                            decoration: InputDecoration(
                              labelText: 'Case Status',
                              prefixIcon: Icon(
                                Icons.filter_alt,
                                color: Color(0xFFFF3D00),
                              ),
                              labelStyle: GoogleFonts.roboto(
                                color: Color(0xFFFFD180),
                              ),
                              hintStyle: GoogleFonts.roboto(
                                color: Color(0xFFFFD180).withOpacity(0.7),
                              ),
                              filled: true,
                              fillColor: Color(0xFF1E3050),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFFFF3D00),
                                ),
                              ),
                            ),
                            dropdownColor: Color(0xFF1E3050),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.add_comment, color: Colors.white),
                            label: Text(
                              'New Thread',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFC4100),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('New Thread'),
                                  content: Text(
                                    'Thread creation feature coming soon!',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              'Forum Thread ${index + 1}',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Discussion about case ${index + 1}',
                              style: GoogleFonts.roboto(
                                color: Color(0xFFFFD180),
                              ),
                            ),
                            trailing: Icon(
                              Icons.thumb_up,
                              color: Color(0xFFFF3D00),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Case Discussion'),
                                  content: Text(
                                    'Discussion feature coming soon!',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
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
        currentIndex: 2,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Recent Cases',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.psychology), label: 'AI'),
        ],
      ),
    );
  }
}
