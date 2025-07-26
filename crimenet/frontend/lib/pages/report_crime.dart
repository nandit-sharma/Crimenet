import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import '../widgets/modern_button.dart';

class ReportCrimePage extends StatefulWidget {
  @override
  State<ReportCrimePage> createState() => _ReportCrimePageState();
}

class _ReportCrimePageState extends State<ReportCrimePage> {
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
        title: Text('Report a Crime', style: TextStyle(color: Colors.white)),
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
          child: Padding(
            padding: EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Submit a New Crime',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFC55A),
                    ),
                  ),
                  SizedBox(height: 24),
                  DropdownButtonFormField<String>(
                    value: crimeType,
                    items: crimeTypes
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) => setState(() => crimeType = v),
                    decoration: InputDecoration(
                      labelText: 'Crime Type',
                      prefixIcon: Icon(Icons.warning, color: Color(0xFFFC4100)),
                    ),
                    dropdownColor: Color.fromARGB(255, 57, 89, 131),
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: state,
                    items: stateOptions
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) {
                        setState(() => state = v);
                        updateCities(v);
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'State',
                      prefixIcon: Icon(Icons.map, color: Color(0xFFFC4100)),
                    ),
                    dropdownColor: Color.fromARGB(255, 57, 89, 131),
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: city,
                    items: cityOptions
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) => setState(() => city = v),
                    decoration: InputDecoration(
                      labelText: 'City',
                      prefixIcon: Icon(
                        Icons.location_city,
                        color: Color(0xFFFC4100),
                      ),
                    ),
                    dropdownColor: Color.fromARGB(255, 57, 89, 131),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      prefixIcon: Icon(Icons.title, color: Color(0xFFFC4100)),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _descController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      prefixIcon: Icon(
                        Icons.description,
                        color: Color(0xFFFC4100),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    maxLines: 3,
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _evidenceController,
                    decoration: InputDecoration(
                      labelText: 'Evidence (URL or description)',
                      prefixIcon: Icon(
                        Icons.attach_file,
                        color: Color(0xFFFC4100),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
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
                                color: Color(0xFFFC4100),
                              ),
                            ),
                            child: Text(
                              date == null
                                  ? 'Select Date'
                                  : '${date!.toLocal()}'.split(' ')[0],
                              style: TextStyle(color: Colors.white),
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
                                color: Color(0xFFFC4100),
                              ),
                            ),
                            child: Text(
                              time == null
                                  ? 'Select Time'
                                  : time!.format(context),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  ModernButton(
                    text: 'Submit',
                    icon: Icons.send,
                    onPressed: () {},
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
