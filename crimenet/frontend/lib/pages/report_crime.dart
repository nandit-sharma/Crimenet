import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';

class ReportCrimePage extends StatefulWidget {
  @override
  State<ReportCrimePage> createState() => _ReportCrimePageState();
}

class _ReportCrimePageState extends State<ReportCrimePage>
    with SingleTickerProviderStateMixin {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _evidenceController = TextEditingController();
  String? crimeType;
  String? state;
  String? city;
  DateTime? date;
  TimeOfDay? time;
  final crimeTypes = [
    'Missing',
    'Theft',
    'Murder',
    'Rape',
    'Assault',
    'Robbery',
    'Kidnapping',
    'Cybercrime',
    'Other',
  ];
  Map<String, List<String>> stateCityMap = {};
  List<String> stateOptions = [];
  List<String> cityOptions = [];
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
    loadStateCityData();
  }

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    _descController.dispose();
    _evidenceController.dispose();
    super.dispose();
  }

  Future<void> loadStateCityData() async {
    final String response = await rootBundle.loadString('assets/Data.json');
    final data = json.decode(response) as Map<String, dynamic>;
    setState(() {
      stateCityMap = data.map((k, v) => MapEntry(k, List<String>.from(v)));
      stateOptions = stateCityMap.keys.toList();
    });
  }

  void updateCities(String selectedState) {
    setState(() {
      cityOptions = stateCityMap[selectedState] ?? [];
      city = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Report a Crime',
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
            padding: EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Submit a New Crime',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFD180),
                      ),
                    ),
                    SizedBox(height: 24),
                    DropdownButtonFormField<String>(
                      value: crimeType,
                      items: crimeTypes
                          .map(
                            (c) => DropdownMenuItem(
                              value: c,
                              child: Text(
                                c,
                                style: GoogleFonts.roboto(color: Colors.white),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => crimeType = v),
                      decoration: InputDecoration(
                        labelText: 'Crime Type',
                        prefixIcon: Icon(
                          Icons.warning,
                          color: Color(0xFFFF3D00),
                        ),
                        labelStyle: GoogleFonts.roboto(
                          color: Color(0xFFFFD180),
                        ),
                      ),
                      dropdownColor: Color(0xFF1E3050),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: state,
                      items: stateOptions
                          .map(
                            (s) => DropdownMenuItem(
                              value: s,
                              child: Text(
                                s,
                                style: GoogleFonts.roboto(color: Colors.white),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        if (v != null) {
                          setState(() => state = v);
                          updateCities(v);
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'State',
                        prefixIcon: Icon(Icons.map, color: Color(0xFFFF3D00)),
                        labelStyle: GoogleFonts.roboto(
                          color: Color(0xFFFFD180),
                        ),
                      ),
                      dropdownColor: Color(0xFF1E3050),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: city,
                      items: cityOptions
                          .map(
                            (c) => DropdownMenuItem(
                              value: c,
                              child: Text(
                                c,
                                style: GoogleFonts.roboto(color: Colors.white),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => city = v),
                      decoration: InputDecoration(
                        labelText: 'City',
                        prefixIcon: Icon(
                          Icons.location_city,
                          color: Color(0xFFFF3D00),
                        ),
                        labelStyle: GoogleFonts.roboto(
                          color: Color(0xFFFFD180),
                        ),
                      ),
                      dropdownColor: Color(0xFF1E3050),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        prefixIcon: Icon(Icons.title, color: Color(0xFFFF3D00)),
                        labelStyle: GoogleFonts.roboto(
                          color: Color(0xFFFFD180),
                        ),
                      ),
                      style: GoogleFonts.roboto(color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _descController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        prefixIcon: Icon(
                          Icons.description,
                          color: Color(0xFFFF3D00),
                        ),
                        labelStyle: GoogleFonts.roboto(
                          color: Color(0xFFFFD180),
                        ),
                      ),
                      style: GoogleFonts.roboto(color: Colors.white),
                      maxLines: 3,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _evidenceController,
                      decoration: InputDecoration(
                        labelText: 'Evidence (URL or description)',
                        prefixIcon: Icon(
                          Icons.attach_file,
                          color: Color(0xFFFF3D00),
                        ),
                        labelStyle: GoogleFonts.roboto(
                          color: Color(0xFFFFD180),
                        ),
                      ),
                      style: GoogleFonts.roboto(color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) setState(() => date = picked);
                            },
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Date',
                                prefixIcon: Icon(
                                  Icons.date_range,
                                  color: Color(0xFFFF3D00),
                                ),
                                labelStyle: GoogleFonts.roboto(
                                  color: Color(0xFFFFD180),
                                ),
                              ),
                              child: Text(
                                date == null
                                    ? 'Select Date'
                                    : '${date!.toLocal()}'.split(' ')[0],
                                style: GoogleFonts.roboto(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (picked != null) setState(() => time = picked);
                            },
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Time',
                                prefixIcon: Icon(
                                  Icons.access_time,
                                  color: Color(0xFFFF3D00),
                                ),
                                labelStyle: GoogleFonts.roboto(
                                  color: Color(0xFFFFD180),
                                ),
                              ),
                              child: Text(
                                time == null
                                    ? 'Select Time'
                                    : time!.format(context),
                                style: GoogleFonts.roboto(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.send, color: Colors.white),
                        label: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFC4100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: () {
                          // TODO: Implement crime submission logic
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF1E3050),
        selectedItemColor: Color(0xFFFF3D00),
        unselectedItemColor: Colors.white.withOpacity(0.7),
        currentIndex: 0,
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
