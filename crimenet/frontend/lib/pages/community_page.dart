import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

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
      if (stateOptions.isNotEmpty) {
        selectedState = stateOptions[0];
        cityOptions = stateCityMap[selectedState] ?? [];
        if (cityOptions.isNotEmpty) selectedCity = cityOptions[0];
      }
    });
  }

  void updateCities(String selectedState) {
    setState(() {
      cityOptions = stateCityMap[selectedState] ?? [];
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
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
          ),
          title: Text('Community', style: TextStyle(color: Colors.white)),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
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
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(color: Color(0xFF00215E)),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        if (v != null) {
                          setState(() => selectedState = v);
                          updateCities(v);
                          if (cityOptions.isNotEmpty)
                            selectedCity = cityOptions[0];
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'State',
                        prefixIcon: Icon(Icons.map, color: Color(0xFFFC4100)),
                      ),
                      dropdownColor: Color.fromARGB(255, 57, 89, 131),
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
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(color: Color(0xFF00215E)),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => selectedCity = v),
                      decoration: InputDecoration(
                        labelText: 'City',
                        prefixIcon: Icon(
                          Icons.location_city,
                          color: Color(0xFFFC4100),
                        ),
                      ),
                      dropdownColor: Color.fromARGB(255, 57, 89, 131),
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
                              : '${selectedDate!.toLocal()}'.split(' ')[0],
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
              SizedBox(height: 16),
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
    );
  }
}
