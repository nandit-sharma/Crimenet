import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import '../widgets/modern_button.dart';

class CommunityPage extends StatefulWidget {
  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  String? selectedState;
  String? selectedCity;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  Map<String, List<String>> stateCityMap = {};
  List<String> stateOptions = [];
  List<String> cityOptions = [];
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
      cityOptions = [];
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/home');
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
          ),
          title: Text('Community', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF101A30), Color(0xFF1E3050)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF2C4E80), Color(0xFF101A30)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: selectedState,
                                isExpanded: true,
                                items: stateOptions
                                    .map(
                                      (s) => DropdownMenuItem(
                                        value: s,
                                        child: Text(
                                          s,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (v) {
                                  setState(() => selectedState = v);
                                  updateCities(v);
                                },
                                decoration: InputDecoration(
                                  labelText: 'State',
                                  hintText: 'State',
                                  prefixIcon: Icon(
                                    Icons.map,
                                    color: Color(0xFFFC4100),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFF1E3050),
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(color: Colors.white70),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Color(0xFFFC4100),
                                    ),
                                  ),
                                ),
                                dropdownColor: Color(0xFF1E3050),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: selectedCity,
                                isExpanded: true,
                                items: cityOptions
                                    .map(
                                      (c) => DropdownMenuItem(
                                        value: c,
                                        child: Text(
                                          c,
                                          style: TextStyle(color: Colors.white),
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
                                    color: Color(0xFFFC4100),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFF1E3050),
                                  labelStyle: TextStyle(color: Colors.white),
                                  hintStyle: TextStyle(color: Colors.white70),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Color(0xFFFC4100),
                                    ),
                                  ),
                                ),
                                dropdownColor: Color(0xFF1E3050),
                                style: TextStyle(color: Colors.white),
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
                                        : '${selectedDate!.toLocal()}'.split(
                                            ' ',
                                          )[0],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
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
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: [
                        Card(
                          child: ListTile(
                            title: Text(
                              '[$selectedState - $selectedCity] Forum Thread 1',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Discussion about case 1',
                              style: TextStyle(color: Color(0xFFFFC55A)),
                            ),
                            trailing: Icon(
                              Icons.thumb_up,
                              color: Color(0xFFFC4100),
                            ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text(
                              '[$selectedState - $selectedCity] Forum Thread 2',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Discussion about case 2',
                              style: TextStyle(color: Color(0xFFFFC55A)),
                            ),
                            trailing: Icon(
                              Icons.thumb_up,
                              color: Color(0xFFFC4100),
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
      ),
    );
  }
}
