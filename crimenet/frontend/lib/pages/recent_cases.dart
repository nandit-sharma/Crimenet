import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';

class RecentCasesPage extends StatefulWidget {
  @override
  State<RecentCasesPage> createState() => _RecentCasesPageState();
}

class _RecentCasesPageState extends State<RecentCasesPage>
    with SingleTickerProviderStateMixin {
  String? selectedState;
  String? selectedCity;
  String? selectedType;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  Map<String, List<String>> stateCityMap = {};
  List<String> stateOptions = [];
  List<String> cityOptions = [];
  final List<String> types = ['Theft', 'Murder', 'Rape', 'Missing', 'Other'];
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
      selectedState = null;
      selectedCity = null;
      isLoading = false;
    });
  }

  void updateCities(String? state) {
    setState(() {
      selectedState = state;
      cityOptions = state != null ? stateCityMap[state] ?? [] : [];
      selectedCity = cityOptions.isNotEmpty ? cityOptions[0] : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recent Cases Solved',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: Color(0xFFFF3D00)))
            : Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0A1C3A), Color(0xFF1E3050)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: [
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          Row(
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
                                        updateCities(v);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'State',
                                      hintText: 'State',
                                      prefixIcon: Icon(
                                        Icons.map,
                                        color: Color(0xFFFF3D00),
                                      ),
                                      labelStyle: GoogleFonts.roboto(
                                        color: Color(0xFFFFD180),
                                      ),
                                      hintStyle: GoogleFonts.roboto(
                                        color: Color(
                                          0xFFFFD180,
                                        ).withOpacity(0.7),
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
                                    onChanged: (v) =>
                                        setState(() => selectedCity = v),
                                    decoration: InputDecoration(
                                      labelText: 'City',
                                      hintText: 'City',
                                      prefixIcon: Icon(
                                        Icons.location_city,
                                        color: Color(0xFFFF3D00),
                                      ),
                                      labelStyle: GoogleFonts.roboto(
                                        color: Color(0xFFFFD180),
                                      ),
                                      hintStyle: GoogleFonts.roboto(
                                        color: Color(
                                          0xFFFFD180,
                                        ).withOpacity(0.7),
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
                          SizedBox(height: 12),
                          Row(
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
                                    value: selectedType,
                                    isExpanded: true,
                                    items: types
                                        .map(
                                          (t) => DropdownMenuItem(
                                            value: t,
                                            child: Text(
                                              t,
                                              style: GoogleFonts.roboto(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (v) =>
                                        setState(() => selectedType = v),
                                    decoration: InputDecoration(
                                      labelText: 'Case Type',
                                      prefixIcon: Icon(
                                        Icons.filter_alt,
                                        color: Color(0xFFFF3D00),
                                      ),
                                      labelStyle: GoogleFonts.roboto(
                                        color: Color(0xFFFFD180),
                                      ),
                                      hintStyle: GoogleFonts.roboto(
                                        color: Color(
                                          0xFFFFD180,
                                        ).withOpacity(0.7),
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
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return FadeTransition(
                          opacity: _fadeAnimation,
                          child: Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: Icon(
                                Icons.check_circle,
                                color: Color(0xFFFF3D00),
                              ),
                              title: Text(
                                'Case ${index + 1}',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Solved',
                                style: GoogleFonts.roboto(
                                  color: Color(0xFFFFD180),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF1E3050),
        selectedItemColor: Color(0xFFFF3D00),
        unselectedItemColor: Colors.white.withOpacity(0.7),
        currentIndex: 1,
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

  Widget _filterDropdown(
    String label,
    List<String> items,
    String? value,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E3050), Color(0xFF0A1C3A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: value,
        hint: Text(label, style: GoogleFonts.roboto(color: Colors.white)),
        dropdownColor: Color(0xFF1E3050),
        icon: const Icon(Icons.arrow_drop_down, color: Color(0xFFFFD180)),
        underline: Container(),
        style: GoogleFonts.roboto(color: Colors.white),
        items: items
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(e, style: GoogleFonts.roboto(color: Colors.white)),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _dateFilter(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) setState(() => selectedDate = picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3050), Color(0xFF0A1C3A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.date_range, color: Color(0xFFFF3D00)),
            const SizedBox(width: 4),
            Text(
              selectedDate == null
                  ? 'Date'
                  : '${selectedDate!.toLocal()}'.split(' ')[0],
              style: GoogleFonts.roboto(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeFilter(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: selectedTime ?? TimeOfDay.now(),
        );
        if (picked != null) setState(() => selectedTime = picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3050), Color(0xFF0A1C3A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.access_time, color: Color(0xFFFF3D00)),
            const SizedBox(width: 4),
            Text(
              selectedTime == null ? 'Time' : selectedTime!.format(context),
              style: GoogleFonts.roboto(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
