import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import '../widgets/shared_layout.dart';

class RecentCasesPage extends StatefulWidget {
  @override
  State<RecentCasesPage> createState() => _RecentCasesPageState();
}

class _RecentCasesPageState extends State<RecentCasesPage> {
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

  @override
  void initState() {
    super.initState();
    loadStateCityData();
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
      selectedCity = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SharedLayout(
      currentIndex: 1,
      title: 'Recent Cases Solved',
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF101A30), Color(0xFF1E3050)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: isLoading
              ? Center(child: CircularProgressIndicator(color: Color(0xFFFC4100)))
              : Padding(
                  padding: EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF1E3050), Color(0xFF101A30)],
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
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: MouseRegion(
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
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
                                                  style: TextStyle(color: Colors.white),
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
                                          hintText: 'State',
                                          prefixIcon: Icon(Icons.map, color: Color(0xFFFC4100)),
                                          filled: true,
                                          fillColor: Color(0xFF1E3050),
                                          labelStyle: TextStyle(color: Colors.white),
                                          hintStyle: TextStyle(color: Colors.white70),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: BorderSide(color: Color(0xFFFC4100)),
                                          ),
                                        ),
                                        dropdownColor: Color(0xFF1E3050),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: MouseRegion(
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
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
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (v) => setState(() => selectedCity = v),
                                        decoration: InputDecoration(
                                          labelText: 'City',
                                          hintText: 'City',
                                          prefixIcon: Icon(
                                            Icons.location_city,
                                            color: Color(0xFFFC4100),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFF1E3050),
                                          labelStyle: TextStyle(color: Colors.white),
                                          hintStyle: TextStyle(color: Colors.white70),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: BorderSide(color: Color(0xFFFC4100)),
                                          ),
                                        ),
                                        dropdownColor: Color(0xFF1E3050),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: MouseRegion(
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
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
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (v) => setState(() => selectedType = v),
                                        decoration: InputDecoration(
                                          labelText: 'Type',
                                          hintText: 'Type',
                                          prefixIcon: Icon(
                                            Icons.category,
                                            color: Color(0xFFFC4100),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFF1E3050),
                                          labelStyle: TextStyle(color: Colors.white),
                                          hintStyle: TextStyle(color: Colors.white70),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: BorderSide(color: Color(0xFFFC4100)),
                                          ),
                                        ),
                                        dropdownColor: Color(0xFF1E3050),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      final picked = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      );
                                      if (picked != null)
                                        setState(() => selectedDate = picked);
                                    },
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                        labelText: 'Date',
                                        prefixIcon: Icon(
                                          Icons.date_range,
                                          color: Color(0xFFFC4100),
                                        ),
                                      ),
                                      child: Text(
                                        selectedDate == null
                                            ? 'Select Date'
                                            : '${selectedDate!.toLocal()}'.split(' ')[0],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      final picked = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (picked != null)
                                        setState(() => selectedTime = picked);
                                    },
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                        labelText: 'Time',
                                        prefixIcon: Icon(
                                          Icons.access_time,
                                          color: Color(0xFFFC4100),
                                        ),
                                      ),
                                      child: Text(
                                        selectedTime == null
                                            ? 'Select Time'
                                            : selectedTime!.format(context),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: ListView(
                          children: [
                            MouseRegion(
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                child: Card(
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.check_circle,
                                      color: Color(0xFFFC4100),
                                    ),
                                    title: Text(
                                      'Case 1',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Solved',
                                      style: TextStyle(color: Color(0xFFFFC55A)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            MouseRegion(
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                child: Card(
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.check_circle,
                                      color: Color(0xFFFC4100),
                                    ),
                                    title: Text(
                                      'Case 2',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Solved',
                                      style: TextStyle(color: Color(0xFFFFC55A)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
